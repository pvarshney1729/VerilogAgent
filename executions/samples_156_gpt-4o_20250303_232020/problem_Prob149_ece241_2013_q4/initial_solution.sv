module TopModule(
    input logic clk,          // Clock input
    input logic reset,        // Active-high synchronous reset
    input logic [2:0] s,      // 3-bit input representing sensor states
    output logic fr2,         // Output for flow rate control
    output logic fr1,         // Output for flow rate control
    output logic fr0,         // Output for flow rate control
    output logic dfr          // Output for supplemental flow control
);

    logic [2:0] prev_s;       // Register to hold the previous state of s

    always_ff @(posedge clk) begin
        if (reset) begin
            // On reset, treat s as 3'b000 and set all outputs to 1
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_s <= 3'b000;
        end else begin
            // Update outputs based on current state of s
            case (s)
                3'b111: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b011: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                3'b001: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                3'b000: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= 1'b0;
                end
                default: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                    dfr <= 1'b0;
                end
            endcase

            // Determine dfr based on previous and current state of s
            if (s > prev_s) begin
                dfr <= 1'b1;
            end

            // Update previous state
            prev_s <= s;
        end
    end

endmodule