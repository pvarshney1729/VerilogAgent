```
[BEGIN]
module TopModule (
    input  logic clk,             // Clock signal (1 bit input)
    input  logic reset,           // Active high synchronous reset (1 bit input)
    output logic [3:0] q          // 4-bit output representing the counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset counter to 0
    end else begin
        q <= (q == 4'b1111) ? 4'b0000 : q + 1; // Increment counter or wrap around
    end
end

endmodule
[DONE]
```