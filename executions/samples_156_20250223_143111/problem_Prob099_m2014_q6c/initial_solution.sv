module TopModule
(
  input  logic [5:0] y,
  input  logic       w,
  output logic       Y1,
  output logic       Y3
);

  // Combinational logic

  assign Y1 = (y[0] & ~w) | (y[2] & ~w) | y[4];
  assign Y3 = (y[1] & ~w) | (y[2] & ~w) | y[4] | (y[5] & w);

endmodule