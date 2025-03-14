[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] in_d; // Delayed version of input

    always @(posedge clk) begin
        in_d <= in; // Store current input on the rising edge of clk
    end

    always @(*) begin
        pedge = (in & ~in_d); // Detect 0 to 1 transitions
    end

endmodule
```
[DONE]