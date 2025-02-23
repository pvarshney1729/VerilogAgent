module TopModule
(
  input  logic a,
  input  logic b,
  input  logic c,
  input  logic d,
  output logic q
);

  // Combinational logic

  assign q = (b & d) | (a & (c | d));

endmodule