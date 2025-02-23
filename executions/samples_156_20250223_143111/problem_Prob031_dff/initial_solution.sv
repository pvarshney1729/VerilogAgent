module TopModule
(
  input  logic clk,
  input  logic d,
  output logic q
);

  // Sequential logic

  always @( posedge clk ) begin
    q <= d;
  end

endmodule