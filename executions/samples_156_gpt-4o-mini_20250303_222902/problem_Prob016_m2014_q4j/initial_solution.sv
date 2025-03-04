```verilog
module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);
    assign sum = x + y; // Full adder logic will inherently handle carry
endmodule
```