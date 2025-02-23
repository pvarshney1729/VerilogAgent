module TopModule
(
  input  logic       clk,
  input  logic       areset,
  input  logic [7:0] d,
  output logic [7:0] q
);

  // Sequential logic

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      q <= 8'b0;
    else
      q <= d;
  end

endmodule