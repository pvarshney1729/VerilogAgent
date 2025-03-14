```verilog
module TopModule (
  input logic a,     // Input signal a (1-bit)
  input logic b,     // Input signal b (1-bit)
  input logic c,     // Input signal c (1-bit)
  input logic d,     // Input signal d (1-bit)
  output logic q     // Output signal q (1-bit)
);

  // Combinational logic for output q
  assign q = (b & d) | (a & c);

endmodule
```