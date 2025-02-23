module TopModule
(
  input  logic [254:0] in,
  output logic [7:0]   out
);

  // Combinational logic

  assign out = $countones(in);

endmodule