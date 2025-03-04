module TopModule (
  input logic clk,
  input logic reset,
  output logic [3:0] q
);

  always_ff @(posedge clk) begin
    if (reset) begin
      q <= 4'b0001; // Reset counter to 1
    end else if (q == 4'b1010) begin
      q <= 4'b0001; // Roll over from 10 to 1
    end else begin
      q <= q + 1; // Increment counter
    end
  end

endmodule