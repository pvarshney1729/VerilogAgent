module TopModule (
    input logic clk,                // Clock signal
    input logic reset,              // Active-high synchronous reset
    input logic [2:0] s,            // 3-bit sensor input, s[2] is the highest sensor
    output logic fr2,               // Output for flow rate control
    output logic fr1,               // Output for flow rate control
    output logic fr0,               // Output for flow rate control
    output logic dfr                // Output for supplemental flow control
);

    logic [2:0] prev_s;             // Register to store previous state of s

    always_ff @(posedge clk) begin
        if (reset) begin
            fr2 <= 1;
            fr1 <= 1;
            fr0 <= 1;
            dfr <= 1;
            prev_s <= 3'b000;
        end else begin
            prev_s <= s;
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
                    dfr <= (prev_s < s) ? 1 : 0;
                end
                3'b001: begin
                    fr2 <= 0;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= (prev_s < s) ? 1 : 0;
                end
                3'b000: begin
                    fr2 <= 1;
                    fr1 <= 1;
                    fr0 <= 1;
                    dfr <= 0;
                end
                default: begin
                    fr2 <= 0;
                    fr1 <= 0;
                    fr0 <= 0;
                    dfr <= 0;
                end
            endcase
        end
    end

endmodule