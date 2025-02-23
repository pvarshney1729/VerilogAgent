module TopModule
(
  input  logic clk,
  input  logic d,
  input  logic r,
  output logic q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( r )
      q <= 0;
    else
      q <= d;
  end

endmodule