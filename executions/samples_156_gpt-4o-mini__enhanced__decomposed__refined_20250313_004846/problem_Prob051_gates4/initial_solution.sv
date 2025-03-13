[BEGIN]
```verilog
module TopModule (
  input  logic [3:0] in, 
  output logic       o_and, 
  output logic       o_or, 
  output logic       o_xor
);

  always @(*) begin
    o_and = &in;
    o_or  = |in;
    o_xor = ^in;
  end

endmodule
```
[DONE]