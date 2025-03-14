[BEGIN]
```verilog
module TopModule (
    input logic clk,            // Clock signal (positive edge triggered)
    input logic reset,          // Active high synchronous reset
    input logic [31:0] in,      // 32-bit input vector (in[0] is LSB, in[31] is MSB)
    output logic [31:0] out      // 32-bit output vector (initially 0, holds captured values)
);

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0; // Synchronous reset to 0
    end else begin
        out <= out | (~in & (out ^ 32'hFFFFFFFF)); // Capture 1 to 0 transitions
    end
end

endmodule
```
[DONE]