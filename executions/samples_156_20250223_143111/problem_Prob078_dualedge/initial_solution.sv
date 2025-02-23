module TopModule
(
  input  logic clk,
  input  logic d,
  output logic q
);

  // Sequential logic

  logic clk_inv, q_posedge, q_negedge;

  always @( posedge clk )
    q_posedge <= d;

  always @( negedge clk )
    q_negedge <= d;

  assign clk_inv = ~clk;

  // Combinational logic

  assign q = clk ? q_posedge : q_negedge;

endmodule