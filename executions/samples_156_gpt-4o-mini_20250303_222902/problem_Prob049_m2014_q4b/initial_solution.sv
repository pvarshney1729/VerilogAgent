```verilog
module TopModule (
  logic clk,
  logic ar,
  logic d,
  logic q
);
  always @(*) begin
    if (ar) begin
      q <= 1'b0;  // Asynchronous reset
    end else if (clk) begin
      q <= d;     // Capture data at positive clock edge
    end
  end
endmodule
```