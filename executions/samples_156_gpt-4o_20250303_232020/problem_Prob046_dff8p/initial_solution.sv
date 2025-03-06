module TopModule (
  input logic clk,         // Clock signal, triggers on the negative edge
  input logic reset,       // Active high synchronous reset
  input logic [7:0] d,     // 8-bit input data bus, unsigned
  output logic [7:0] q     // 8-bit output data bus, unsigned
);

  always @(negedge clk) begin
    if (reset) begin
      q <= 8'b00110100;  // Reset state to 0x34
    end else begin
      q <= d;            // Capture input data
    end
  end

endmodule