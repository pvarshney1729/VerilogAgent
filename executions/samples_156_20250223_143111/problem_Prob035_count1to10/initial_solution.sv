module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic [3:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( reset )
      q <= 4'b0001;
    else if ( q == 4'b1010 )
      q <= 4'b0001;
    else
      q <= q + 1;
  end

endmodule