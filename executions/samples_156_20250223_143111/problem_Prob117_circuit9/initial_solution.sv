module TopModule
(
  input  logic clk,
  input  logic a,
  output logic [2:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( a )
      q <= 3'b100;
    else
      q <= q + 1;
  end

endmodule