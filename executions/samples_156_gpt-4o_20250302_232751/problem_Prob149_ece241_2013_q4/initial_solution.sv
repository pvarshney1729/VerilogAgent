module TopModule (
    input logic clk,            // Clock signal
    input logic reset,          // Active-high synchronous reset
    input logic [2:0] s,        // 3-bit sensor input, s[2] is MSB, s[0] is LSB
    output logic fr2,           // Flow rate control output 2
    output logic fr1,           // Flow rate control output 1
    output logic fr0,           // Flow rate control output 0
    output logic dfr            // Supplemental flow valve control
);

    logic [2:0] prev_s;         // Previous sensor input state

    always_ff @(posedge clk) begin
        if (reset) begin
            fr0 <= 1'b1;
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Determine flow rate control outputs based on current sensor input
            case (s)
                3'b111: begin
                    fr0 <= 1'b0;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                end
                3'b011: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                end
                3'b001: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                end
                3'b000: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                end
                default: begin
                    fr0 <= 1'b0;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                end
            endcase

            // Determine dfr based on previous and current sensor input
            if (s > prev_s) begin
                dfr <= 1'b1;
            end else begin
                dfr <= 1'b0;
            end

            // Update previous sensor state
            prev_s <= s;
        end
    end

endmodule