module TopModule
(
  input  logic clk,
  input  logic in,
  output logic out
);

  // Sequential logic

  always @( posedge clk ) begin
    out <= out ^ in;
  end

endmodule