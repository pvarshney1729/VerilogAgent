module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic slowena,
  output logic [3:0] q
);

  // Sequential logic

  logic [3:0] count;

  always @( posedge clk ) begin
    if ( reset )
      count <= 4'b0000;
    else if ( slowena )
      count <= (count == 4'b1001) ? 4'b0000 : count + 1;
  end

  // Structural connections

  assign q = count;

endmodule