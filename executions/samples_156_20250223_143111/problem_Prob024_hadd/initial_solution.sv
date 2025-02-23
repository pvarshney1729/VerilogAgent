module TopModule
(
  input  logic a,
  input  logic b,
  output logic sum,
  output logic cout
);

  // Combinational logic

  assign sum  = a ^ b;
  assign cout = a & b;

endmodule