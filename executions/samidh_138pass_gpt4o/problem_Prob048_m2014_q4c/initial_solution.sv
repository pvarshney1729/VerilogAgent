```verilog
[BEGIN]
module TopModule (
  input logic clk,  // Clock signal
  input logic d,    // Data input
  input logic r,    // Synchronous reset, active high
  output logic q    // Flip-flop output
);

  always_ff @(posedge clk) begin
    if (r) begin
      q <= 1'b0;  // Reset output to 0
    end else begin
      q <= d;     // Capture data input
    end
  end

endmodule
[DONE]
```