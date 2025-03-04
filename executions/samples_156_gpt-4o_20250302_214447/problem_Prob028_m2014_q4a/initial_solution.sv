```verilog
module TopModule (
  input wire d,    // 1-bit data input
  input wire ena,  // 1-bit enable signal
  output reg q     // 1-bit data output
);

  always @* begin
    if (ena) begin
      q = d;
    end
    // No else condition required as q retains its state when ena is low
  end

endmodule
```