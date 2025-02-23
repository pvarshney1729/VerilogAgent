module TopModule
(
  input  logic clk,
  input  logic a,
  output logic q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( a )
      q <= ~q;
    else
      q <= 1;
  end

endmodule