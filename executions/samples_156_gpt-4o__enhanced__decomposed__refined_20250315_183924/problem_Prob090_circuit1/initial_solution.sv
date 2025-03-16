```verilog
module TopModule (
    input wire a,
    input wire b,
    output wire q
);
    assign q = a & b;  // Logical AND operation
endmodule
```