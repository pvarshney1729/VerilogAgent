```verilog
module TopModule (
    input  wire [99:0] in,       // 100-bit input vector, in[99] is MSB
    output wire        out_and,  // 1-bit output for AND operation
    output wire        out_or,   // 1-bit output for OR operation
    output wire        out_xor   // 1-bit output for XOR operation
);

    // AND operation: result is 1 if all bits are 1
    assign out_and = &in;

    // OR operation: result is 1 if at least one bit is 1
    assign out_or = |in;

    // XOR operation: result is 1 if there is an odd number of 1's
    assign out_xor = ^in;

endmodule