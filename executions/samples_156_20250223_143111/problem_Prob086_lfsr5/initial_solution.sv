module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic [4:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( reset )
      q <= 5'b00001;
    else
      q <= {q[3] ^ q[0], q[4:1]};
  end

endmodule