```
[BEGIN]
module TopModule (
  input logic clk,
  input logic j,
  input logic k,
  input logic reset_n,  // Active low reset
  output logic Q
);

  always @(posedge clk) begin
    if (!reset_n) begin
      Q <= 1'b0;  // Reset to 0
    end else begin
      case ({j, k})
        2'b00: Q <= Q;     // Retain state
        2'b01: Q <= 1'b0;  // Reset
        2'b10: Q <= 1'b1;  // Set
        2'b11: Q <= ~Q;    // Toggle
      endcase
    end
  end

endmodule
[DONE]
```