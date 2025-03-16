```verilog
module TopModule (
  input wire in,  // 1-bit input signal
  output wire out // 1-bit output signal
);

  assign out = in; // Combinational assignment from input to output

endmodule
```