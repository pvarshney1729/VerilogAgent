```verilog
module TopModule (
  input wire in,  // 1-bit unsigned input signal
  output wire out // 1-bit unsigned output signal
);

  assign out = ~in;

endmodule
```