```verilog
[BEGIN]
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic q
);

  always @(*) begin
    q = (b & d) | (c & d) | (a & d);
  end

endmodule
[DONE]
```