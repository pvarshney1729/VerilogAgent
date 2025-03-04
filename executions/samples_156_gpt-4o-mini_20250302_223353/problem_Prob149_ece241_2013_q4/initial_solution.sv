module TopModule (
    input logic clk,           // Clock input
    input logic reset,         // Active-high synchronous reset
    input logic [2:0] s,       // 3-bit sensor input
    output logic fr2,          // Flow rate control output 2
    output logic fr1,          // Flow rate control output 1
    output logic fr0,          // Flow rate control output 0
    output logic dfr           // Supplemental flow valve control
);

    logic [2:0] prev_s;       // Register to hold previous sensor state

    always @(posedge clk) begin
        if (reset) begin
            fr0 <= 1'b1;
            fr1 <= 1'b1;
            fr2 <= 1'b1;
            dfr <= 1'b0;
            prev_s <= 3'b000;  // Initialize previous state
        end else begin
            // Update flow rate controls based on sensor input
            case (s)
                3'b111: begin
                    fr0 <= 1'b0;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b110: begin
                    fr0 <= 1'b1;
                    fr1 <= 1'b0;
                    fr2 <= 1'b0;
                    dfr <= 1'b0;
                end
                3'b100: begin
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
                    fr0 <= 1'b1;
                    fr1 <= 1'b1;
                    fr2 <= 1'b1;
                    dfr <= 1'b1;
                end
            endcase
            
            // Determine if dfr should be asserted
            dfr <= (prev_s < s) ? 1'b1 : 1'b0;
            prev_s <= s;  // Update previous state
        end
    end
endmodule