module TopModule
(
  input  logic clk,
  input  logic a,
  input  logic b,
  output logic q,
  output logic state
);

  // Sequential logic

  always @( posedge clk ) begin
    state <= a & b;
  end

  // Combinational logic

  assign q = state | b;

endmodule