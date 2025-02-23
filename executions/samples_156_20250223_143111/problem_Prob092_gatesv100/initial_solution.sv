module TopModule
(
  input  logic [99:0] in,
  output logic [99:0] out_both,
  output logic [99:0] out_any,
  output logic [99:0] out_different
);

  // Combinational logic

  assign out_both      = {1'b0, in[99:1] & in[98:0]};
  assign out_any       = {in[1:0] | in[0], 1'b0};
  assign out_different = {in[0] ^ in[99], in[99:1] ^ in[98:0]};

endmodule