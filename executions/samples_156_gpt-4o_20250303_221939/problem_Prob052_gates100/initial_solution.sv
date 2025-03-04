```verilog
module TopModule (
    input [99:0] in, // 100-bit input vector, where in[0] is the LSB and in[99] is the MSB
    output logic out_and,  // Single-bit output for the AND operation
    output logic out_or,   // Single-bit output for the OR operation
    output logic out_xor   // Single-bit output for the XOR operation
);

    // Implementing the AND operation
    assign out_and = &in;

    // Implementing the OR operation
    assign out_or = |in;

    // Implementing the XOR operation
    assign out_xor = ^in;

endmodule
```