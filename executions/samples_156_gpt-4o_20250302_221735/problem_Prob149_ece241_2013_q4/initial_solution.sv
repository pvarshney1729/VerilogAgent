module TopModule(
    input logic clk,              // Clock signal
    input logic reset,            // Active-high synchronous reset
    input logic [2:0] s,          // 3-bit input representing sensor states
    output logic fr2,             // Output for flow rate control
    output logic fr1,             // Output for flow rate control
    output logic fr0,             // Output for flow rate control
    output logic dfr              // Output for supplemental flow control
);

    logic [2:0] prev_s;           // Register to track the previous state of s

    always_ff @(posedge clk) begin
        if (reset) begin
            // Reset condition: all outputs are asserted
            fr0 <= 1'b1;
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Update previous state
            prev_s <= s;

            // Determine outputs based on current state
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
                    dfr <= (prev_s < s) ? 1'b1 : 1'b0;
                end
                3'b001: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b0;
                    dfr <= (prev_s < s) ? 1'b1 : 1'b0;
                end
                3'b000: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    dfr <= 1'b1;
                end
                default: begin
                    // Default case to handle any unexpected states
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
        end
    end

endmodule