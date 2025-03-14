[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

logic [7:0] in_d; // Delayed input to detect edges

always @(posedge clk) begin
    in_d <= in; // Store the current input for edge detection
    pedge <= (in & ~in_d); // Detect positive edges
end

endmodule
```
[DONE]