module TopModule
(
  input  logic a,
  input  logic b,
  input  logic c,
  input  logic d,
  output logic out_sop,
  output logic out_pos
);

  // Combinational logic

  assign out_sop = (~a & ~b & c & d) | (~a & b & ~c & d) | (a & b & c & d);

  assign out_pos = ~(~(~a & ~b & c & d) & ~(~a & b & ~c & d) & ~(a & b & c & d));

endmodule