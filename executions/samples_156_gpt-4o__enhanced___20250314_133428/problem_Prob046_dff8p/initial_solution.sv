module TopModule (
  input        clk,        // System clock, active on the negative edge
  input        reset,      // Active high synchronous reset
  input  [7:0] d,          // 8-bit input data bus
  output reg [7:0] q       // 8-bit output data bus
);

  always @(negedge clk) begin
    if (reset) begin
      q <= 8'b00110100; // Reset to 0x34
    end else begin
      q <= d;
    end
  end

endmodule