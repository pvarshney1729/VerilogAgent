module TopModule
(
  input  logic [2:0] in,
  output logic [1:0] out
);

  // Combinational logic

  assign out = in[0] + in[1] + in[2];

endmodule