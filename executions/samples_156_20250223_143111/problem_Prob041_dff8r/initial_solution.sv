module TopModule
(
  input  logic       clk,
  input  logic       reset,
  input  logic [7:0] d,
  output logic [7:0] q
);

  // Sequential logic

  always @( posedge clk or posedge reset ) begin
    if ( reset )
      q <= 8'b0;
    else
      q <= d;
  end

endmodule