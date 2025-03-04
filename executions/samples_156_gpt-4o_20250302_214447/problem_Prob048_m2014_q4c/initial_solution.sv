```verilog
module TopModule (
  input logic clk,  // Clock signal
  input logic d,    // Data input
  input logic r,    // Synchronous reset
  output logic q    // Output
);

  // On the rising edge of the clock, check the reset and data input
  always @(posedge clk) begin
    if (r) begin
      q <= 1'b0; // Reset output to 0
    end else begin
      q <= d; // Latch data input
    end
  end

endmodule
```