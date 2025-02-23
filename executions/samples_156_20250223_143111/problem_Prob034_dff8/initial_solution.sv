module TopModule
(
  input  logic       clk,
  input  logic [7:0] d,
  output logic [7:0] q
);

  // Sequential logic

  always @( posedge clk ) begin
    q <= d;
  end

endmodule