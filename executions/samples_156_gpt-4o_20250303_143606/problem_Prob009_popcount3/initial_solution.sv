```verilog
module TopModule (
    input  wire [2:0] in,   // 3-bit input vector, in[2] is MSB, in[0] is LSB
    output wire [1:0] out   // 2-bit output vector, representing the population count
);

    // Compute the population count using bitwise operations
    assign out = in[2] + in[1] + in[0];

endmodule
```