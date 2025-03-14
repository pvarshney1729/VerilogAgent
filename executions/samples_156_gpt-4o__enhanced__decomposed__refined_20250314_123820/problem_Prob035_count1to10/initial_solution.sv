[BEGIN]
module TopModule (
    input  logic clk,           // Clock input, positive edge triggered
    input  logic reset,         // Active high, synchronous reset
    output logic [3:0] q        // 4-bit output representing the counter value
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // Reset to 1
        end else if (q == 4'b1010) begin
            q <= 4'b0001; // Wrap around from 10 to 1
        end else begin
            q <= q + 1;   // Increment counter
        end
    end

endmodule
[DONE]