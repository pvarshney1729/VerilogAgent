module TopModule (
    input logic clk,             // Clock input
    input logic reset,           // Active-high synchronous reset
    input logic [2:0] s,         // 3-bit water level sensor input, s[2] = highest sensor
    output logic fr2,            // Flow rate control output 2
    output logic fr1,            // Flow rate control output 1
    output logic fr0,            // Flow rate control output 0
    output logic dfr             // Supplemental flow control output
);

    logic [2:0] prev_s;          // Register to hold the previous state of s

    // Sequential logic to capture previous state and handle reset
    always_ff @(posedge clk) begin
        if (reset) begin
            prev_s <= 3'b000;
            fr2 <= 1;
            fr1 <= 1;
            fr0 <= 1;
            dfr <= 1;
        end else begin
            prev_s <= s;
            // Determine flow rate control outputs based on current sensor input
            case (s)
                3'b111: begin
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 0;
                    dfr <= 0;
                end
                3'b011: begin
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 1;
                    dfr <= 0;
                end
                3'b001: begin
                    fr2 <= 0;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= 0;
                end
                3'b000: begin
                    fr2 <= 1;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= 1;
                end
                default: begin
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 0;
                    dfr <= 0;
                end
            endcase

            // Determine supplemental flow control based on transition
            if (s > prev_s) begin
                dfr <= 1;
            end else begin
                dfr <= 0;
            end
        end
    end

endmodule