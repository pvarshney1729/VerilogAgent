```
[BEGIN]
module TopModule (
    input logic clk,           // Clock input, positive edge triggered
    input logic reset,         // Active high, synchronous reset input
    output logic [9:0] q       // 10-bit output, representing the current counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 10'b0000000000; // Reset counter to 0
    end else if (q == 10'd999) begin
        q <= 10'b0000000000; // Wrap around to 0 when reaching 999
    end else begin
        q <= q + 10'b0000000001; // Increment counter
    end
end

endmodule
[DONE]
```