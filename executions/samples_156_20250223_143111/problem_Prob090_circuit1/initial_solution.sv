module TopModule
(
  input  logic a,
  input  logic b,
  output logic q
);

  // Combinational logic

  assign q = a & b;

endmodule