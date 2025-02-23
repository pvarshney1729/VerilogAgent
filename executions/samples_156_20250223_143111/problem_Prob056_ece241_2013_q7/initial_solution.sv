module TopModule
(
  input  logic clk,
  input  logic j,
  input  logic k,
  output logic Q
);

  // Sequential logic

  always @( posedge clk ) begin
    if ( j == 0 && k == 0 )
      Q <= Q;
    else if ( j == 0 && k == 1 )
      Q <= 0;
    else if ( j == 1 && k == 0 )
      Q <= 1;
    else if ( j == 1 && k == 1 )
      Q <= ~Q;
  end

endmodule