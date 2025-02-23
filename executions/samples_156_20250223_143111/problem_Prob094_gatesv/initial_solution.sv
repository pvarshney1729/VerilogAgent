module TopModule
(
  input  logic [3:0] in,
  output logic [3:0] out_both,
  output logic [3:0] out_any,
  output logic [3:0] out_different
);

  // Combinational logic

  assign out_both[3:1] = in[3:1] & in[2:0];
  assign out_both[0] = 0;

  assign out_any[2:0] = in[2:0] | in[1:0];
  assign out_any[3] = in[3] | in[0];

  assign out_different[3:1] = in[3:1] ^ in[2:0];
  assign out_different[0] = in[3] ^ in[0];

endmodule