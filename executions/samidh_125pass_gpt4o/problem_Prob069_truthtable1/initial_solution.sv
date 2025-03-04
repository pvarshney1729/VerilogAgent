```verilog
module TopModule (
    input logic x3,  // 1-bit input, MSB of input vector
    input logic x2,  // 1-bit input, middle bit of input vector
    input logic x1,  // 1-bit input, LSB of input vector
    output logic f   // 1-bit output
);

    assign f = (x2 & ~x3) | (x1 & x3);

endmodule
```