module TopModule
(
  input  logic       clk,
  input  logic       areset,
  input  logic       load,
  input  logic       ena,
  input  logic [3:0] data,
  output logic [3:0] q
);

  // Sequential logic

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      q <= 4'b0000;
    else if ( load )
      q <= data;
    else if ( ena )
      q <= q >> 1;
  end

endmodule