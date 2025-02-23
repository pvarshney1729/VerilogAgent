module TopModule
(
  input  logic clk,
  input  logic reset,
  output logic [3:0] q
);

  // Sequential logic

  always @( posedge clk or posedge reset ) begin
    if ( reset )
      q <= 4'b0000;
    else
      q <= q + 1;
  end

endmodule