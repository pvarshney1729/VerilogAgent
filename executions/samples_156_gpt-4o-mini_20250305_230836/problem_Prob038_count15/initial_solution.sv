[BEGIN]
```verilog
module TopModule (
    logic clk,
    logic reset,
    logic [3:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000;  // Reset counter to 0
    end else begin
        q <= q + 4'b0001;  // Increment counter
    end
end

endmodule
```
[DONE]