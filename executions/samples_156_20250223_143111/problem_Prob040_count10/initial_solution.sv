module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic [3:0] q
);

  // Sequential logic

  logic [3:0] reg_q;

  always @( posedge clk ) begin
    if ( reset )
      reg_q <= 4'b0000;
    else if ( reg_q == 4'b1001 )
      reg_q <= 4'b0000;
    else
      reg_q <= reg_q + 1;
  end

  // Structural connections

  assign q = reg_q;

endmodule