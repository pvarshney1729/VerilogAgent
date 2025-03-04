module TopModule (
  logic clk,
  logic reset,
  logic [31:0] in,
  logic [31:0] out
);

  logic [31:0] prev_in; // Register to hold the previous state of 'in'

  always @(posedge clk) begin
    if (reset) begin
      out <= 32'h0; // Reset output to zero
    end else begin
      // Capture 1-to-0 transitions
      out <= out | (prev_in & ~in);
    end
    prev_in <= in; // Update the previous input state
  end

endmodule