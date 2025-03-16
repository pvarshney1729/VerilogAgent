```verilog
module TopModule (
    input wire [7:0] in,      // 8-bit input data, in[7] is MSB, in[0] is LSB
    output wire parity        // 1-bit output for even parity
);

    // Compute even parity using the reduction XOR operator
    assign parity = ^in; // Verilog reduction XOR operator for even parity

endmodule
```