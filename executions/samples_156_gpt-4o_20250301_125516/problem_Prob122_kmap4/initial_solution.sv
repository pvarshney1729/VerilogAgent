```verilog
module TopModule (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  output logic out
);
  // Implement the logic based on the Karnaugh map
  assign out = (c & ~d) | (~c & d);
endmodule
```