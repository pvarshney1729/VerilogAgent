```verilog
[BEGIN]
module TopModule (
  input logic clk,
  input logic d,
  input logic rst,
  output logic q
);

  always @(posedge clk) begin
    if (rst) begin
      q <= 1'b0;  // Reset the flip-flop to 0
    end else begin
      q <= d;     // Capture the input data
    end
  end

endmodule
[DONE]
```