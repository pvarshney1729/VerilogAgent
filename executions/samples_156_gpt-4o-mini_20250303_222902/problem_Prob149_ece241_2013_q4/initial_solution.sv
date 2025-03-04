module TopModule (
    input logic clk,            // Clock signal
    input logic reset,          // Active-high synchronous reset
    input logic [2:0] s,        // 3-bit sensor input: s[2] = highest, s[0] = lowest
    output logic fr2,           // Flow rate control output 2
    output logic fr1,           // Flow rate control output 1
    output logic fr0,           // Flow rate control output 0
    output logic dfr            // Supplemental flow valve control
);

    logic [2:0] prev_s;        // Register to store previous sensor state

    always @(posedge clk) begin
        if (reset) begin
            fr2 <= 1'b1;        // Reset state for fr2
            fr1 <= 1'b1;        // Reset state for fr1
            fr0 <= 1'b1;        // Reset state for fr0
            dfr <= 1'b0;        // Reset state for dfr
            prev_s <= 3'b000;   // Initialize previous sensor state
        end else begin
            prev_s <= s;        // Store current sensor state as previous
            case (s)
                3'b111: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b0;
                end
                3'b011: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    fr0 <= 1'b1;
                end
                3'b001: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                end
                3'b000: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                end
                default: begin
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                end
            endcase
            
            // Control dfr based on previous state
            dfr <= (s > prev_s) ? 1'b1 : 1'b0;
        end
    end
endmodule