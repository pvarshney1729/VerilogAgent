module TopModule (
    input wire [99:0] in,  // 100-bit input vector, bit[0] is LSB and bit[99] is MSB
    output wire out_and,   // 1-bit output for the AND gate result
    output wire out_or,    // 1-bit output for the OR gate result
    output wire out_xor    // 1-bit output for the XOR gate result
);

    // Continuous assignment for AND operation
    assign out_and = &in;

    // Continuous assignment for OR operation
    assign out_or = |in;

    // Continuous assignment for XOR operation
    assign out_xor = ^in;

endmodule