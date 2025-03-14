[BEGIN]
```verilog
module TopModule (
    input logic clk,          // Clock signal (positive edge triggered)
    input logic areset,      // Active high asynchronous reset signal
    input logic [7:0] d,     // 8-bit input data
    output logic [7:0] q      // 8-bit output data
);

always @(posedge clk) begin
    if (areset) begin
        q <= 8'b00000000;  // Reset state: all bits set to 0
    end else begin
        q <= d;            // On rising edge of clk, output q follows input d
    end
end

endmodule
```
[DONE]