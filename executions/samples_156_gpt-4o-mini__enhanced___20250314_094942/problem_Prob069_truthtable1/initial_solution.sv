```verilog
module TopModule (
    input logic x3,    // Input: Most Significant Bit (MSB)
    input logic x2,    // Input: Middle Bit
    input logic x1,    // Input: Least Significant Bit (LSB)
    output logic f     // Output: One-bit result
);

    assign f = (x2 & ~x3) | (x1 & ~x3) | (x1 & x2);

endmodule
```