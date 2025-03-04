```verilog
module TopModule (
  input logic clk,
  input logic w,
  input logic R,
  input logic E,
  input logic L,
  input logic rst,
  output logic Q
);
  always @(posedge clk) begin
    if (rst) begin
      Q <= 1'b0;
    end else if (L) begin
      Q <= R;
    end else if (E) begin
      Q <= w;
    end
  end
endmodule
```