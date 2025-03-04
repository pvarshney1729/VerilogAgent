module TopModule (
    input wire clk,                  // Clock signal
    input wire reset,                // Active-high synchronous reset
    input wire [2:0] s,              // 3-bit water level sensor input
    output reg fr2,                  // Flow rate output 2
    output reg fr1,                  // Flow rate output 1
    output reg fr0,                  // Flow rate output 0
    output reg dfr                   // Supplemental flow valve control
);

    reg [2:0] prev_level;            // Register to store previous level

    always @(posedge clk) begin
        if (reset) begin
            // Reset behavior: simulate low water level
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            fr0 <= 1'b1;
            dfr <= 1'b1;
            prev_level <= 3'b000;
        end else begin
            // Determine output based on current and previous level
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
                    dfr <= (prev_level < s) ? 1'b1 : 1'b0;
                end
                3'b001: begin
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    fr0 <= 1'b1;
                    dfr <= (prev_level < s) ? 1'b1 : 1'b0;
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
            // Capture current level as previous level for next cycle
            prev_level <= s;
        end
    end

endmodule