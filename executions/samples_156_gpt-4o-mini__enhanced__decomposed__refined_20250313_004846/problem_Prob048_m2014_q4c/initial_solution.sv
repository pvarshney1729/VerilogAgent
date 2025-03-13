[BEGIN]
```verilog
module TopModule (
  input logic clk,
  input logic d,
  input logic r,
  output logic q
);

always @(posedge clk) begin
  if (r) begin
    q <= 1'b0; // Reset output to 0
  end else begin
    q <= d; // Sample data input
  end
end

endmodule
```
[DONE]