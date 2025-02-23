module TopModule
(
  input  logic       clk,
  input  logic       reset,
  output logic [2:0] ena,
  output logic [15:0] q
);

  // Sequential logic

  logic [15:0] reg_q;

  always @( posedge clk ) begin
    if ( reset )
      reg_q <= 16'b0000_0000_0000_0000;
    else
      reg_q <= reg_q + 1;
  end

  // Combinational logic

  always @(*) begin
    ena[0] = (reg_q[3:0] == 4'b1001);
    ena[1] = (reg_q[7:4] == 4'b1001) && ena[0];
    ena[2] = (reg_q[11:8] == 4'b1001) && ena[1];
  end

  // Structural connections

  assign q = reg_q;

endmodule