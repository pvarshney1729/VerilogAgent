```verilog
[BEGIN]
module TopModule (
  input logic clk,
  input logic reset_n,
  input logic load,
  input logic [9:0] data,
  output logic tc
);
  logic [9:0] counter;

  always_ff @(posedge clk) begin
    if (!reset_n) begin
      counter <= 10'b0;
      tc <= 1'b0;
    end else if (load) begin
      counter <= data;
      tc <= 1'b0;
    end else if (counter > 10'b0) begin
      counter <= counter - 10'b1;
      if (counter == 10'b1) tc <= 1'b1; // Assert tc when counter reaches 0
    end
  end
endmodule
[DONE]
```