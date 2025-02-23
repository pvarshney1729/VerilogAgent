module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic [9:0] q
);

  // Sequential logic

  logic [9:0] reg_q;

  always @( posedge clk ) begin
    if ( reset )
      reg_q <= 0;
    else if ( reg_q == 999 )
      reg_q <= 0;
    else
      reg_q <= reg_q + 1;
  end

  // Structural connections

  assign q = reg_q;

endmodule