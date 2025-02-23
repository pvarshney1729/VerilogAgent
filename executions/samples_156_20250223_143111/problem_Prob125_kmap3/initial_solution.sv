module TopModule
(
  input  logic a,
  input  logic b,
  input  logic c,
  input  logic d,
  output logic out
);

  // Combinational logic

  assign out = (b & ~c) | (a & b);

endmodule