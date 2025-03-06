```verilog
module TopModule (
    input logic clk,
    input logic rst_n,  // Asynchronous active-low reset
    input logic [7:0] d,  // 8-bit data input
    output logic [7:0] q   // 8-bit data output
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= 8'b00000000;  // Reset output to 0
    end else begin
      q <= d;  // Transfer input to output
    end
  end

endmodule
```