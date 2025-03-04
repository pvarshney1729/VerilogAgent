module TopModule (
    input wire clk,            // Clock signal, positive edge-triggered
    input wire reset,          // Active high, synchronous reset
    output reg [3:0] q         // 4-bit output, unsigned, representing the count
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Reset state
    end else if (q == 4'b1010) begin
        q <= 4'b0001; // Wrap around to 1 after 10
    end else begin
        q <= q + 1;    // Increment counter
    end
end

endmodule