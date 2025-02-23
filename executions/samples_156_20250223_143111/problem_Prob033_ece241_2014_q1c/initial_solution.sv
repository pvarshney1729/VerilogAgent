module TopModule
(
  input  logic [7:0] a,
  input  logic [7:0] b,
  output logic [7:0] s,
  output logic       overflow
);

  // Combinational logic

  assign s = a + b;

  // Overflow occurs if the signs of the inputs are the same and the sign of the sum is different
  assign overflow = (a[7] == b[7]) && (a[7] != s[7]);

endmodule