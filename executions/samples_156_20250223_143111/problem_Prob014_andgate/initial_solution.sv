module TopModule
(
  input  logic a,
  input  logic b,
  output logic out
);

  // Combinational logic

  assign out = a & b;

endmodule