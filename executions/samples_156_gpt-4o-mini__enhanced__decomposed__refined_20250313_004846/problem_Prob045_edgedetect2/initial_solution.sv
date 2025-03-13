```
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic [7:0] in,
    output logic [7:0] anyedge
);

  logic [7:0] in_prev;

  always @(posedge clk) begin
    if (!reset_n) begin
      anyedge <= 8'b0;
      in_prev <= 8'b0;
    end else begin
      anyedge <= (in ^ in_prev);
      in_prev <= in;
    end
  end

endmodule
[DONE]
```