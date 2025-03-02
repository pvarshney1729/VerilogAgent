```verilog
module TopModule (
    input wire a,  // 1-bit input
    input wire b,  // 1-bit input
    output wire q  // 1-bit output
);

    assign q = a & b;

endmodule
```