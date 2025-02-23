module TopModule
(
  input  logic       clk,
  input  logic       load,
  input  logic [511:0] data,
  output logic [511:0] q
);

  // Sequential logic

  logic [511:0] reg_q;

  always @( posedge clk ) begin
    if ( load )
      reg_q <= data;
    else
      reg_q <= q;
  end

  // Combinational logic

  always @(*) begin
    q[0] = reg_q[0] ^ (reg_q[1] | reg_q[511]);
    q[511] = reg_q[511] ^ (reg_q[510] | reg_q[0]);
    for (integer i = 1; i < 511; i = i + 1)
      q[i] = reg_q[i] ^ (reg_q[i+1] | reg_q[i-1]);
  end

endmodule