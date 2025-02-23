module TopModule
(
  input  logic clk,
  input  logic ar,
  input  logic d,
  output logic q
);

  // Sequential logic

  always @( posedge clk or posedge ar ) begin
    if ( ar )
      q <= 0;
    else
      q <= d;
  end

endmodule