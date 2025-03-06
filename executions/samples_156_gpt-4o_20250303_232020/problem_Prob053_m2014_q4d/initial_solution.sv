module TopModule (
  input logic clk,  // Clock input
  input logic in,   // Data input for XOR
  output logic out  // Output of the flip-flop
);

  logic xor_result;

  always_comb begin
    xor_result = in ^ out;
  end

  always_ff @(posedge clk) begin
    out <= xor_result;
  end

endmodule