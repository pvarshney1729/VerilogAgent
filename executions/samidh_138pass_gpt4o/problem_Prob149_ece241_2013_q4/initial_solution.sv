module TopModule (
    input logic clk,                   // Clock signal
    input logic reset,                 // Active-high synchronous reset
    input logic [2:0] s,               // 3-bit sensor input, where s[2] is MSB and s[0] is LSB
    output logic fr2,                  // Flow rate control output 2
    output logic fr1,                  // Flow rate control output 1
    output logic fr0,                  // Flow rate control output 0
    output logic dfr                   // Supplemental flow valve control
);

    logic [2:0] prev_s;                // Register to store previous state of sensors

    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, set all outputs high
            fr0 <= 1'b1;
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Store the previous state of sensors
            prev_s <= s;

            // Determine the flow rate control outputs based on current sensor input
            case (s)
                3'b111: begin
                    fr0 <= 1'b0;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b011: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b001: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b000: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    dfr <= 1'b1;
                end
                default: begin
                    fr0 <= 1'b0;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase

            // Determine if dfr should be high based on previous level influence
            if (s > prev_s) begin
                dfr <= 1'b1;
            end
        end
    end

endmodule