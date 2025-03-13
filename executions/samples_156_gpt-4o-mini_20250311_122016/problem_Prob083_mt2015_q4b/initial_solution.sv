```verilog
[BEGIN]
module TopModule (
  input logic x,
  input logic y,
  input logic clk,
  input logic rst_n,
  output logic z
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n)
    z <= 1'b1; // Reset condition
  else begin
    case ({x, y})
      2'b00: z <= 1'b1;
      2'b01: z <= 1'b0;
      2'b10: z <= 1'b0;
      2'b11: z <= 1'b1;
      default: z <= 1'b1; // Default case for safety
    endcase
  end
end

endmodule
[DONE]
```