module TopModule
(
  input  logic clk,
  input  logic x,
  output logic z
);

  // Sequential logic

  logic q_xor, q_and, q_or;

  always @( posedge clk ) begin
    q_xor <= q_xor ^ x;
    q_and <= q_and & ~x;
    q_or  <= q_or  | ~x;
  end

  // Combinational logic

  assign z = ~(q_xor | q_and | q_or);

endmodule