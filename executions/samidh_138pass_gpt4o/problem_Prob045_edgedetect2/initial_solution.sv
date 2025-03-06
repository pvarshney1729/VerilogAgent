```verilog
module TopModule (
  input logic clk,
  input logic rst_n,
  input logic [7:0] in,
  output logic [7:0] anyedge
);
  logic [7:0] prev_in;

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      anyedge <= 8'b00000000;
      prev_in <= 8'b00000000;
    end else begin
      anyedge <= prev_in ^ in;
      prev_in <= in;
    end
  end
endmodule
```