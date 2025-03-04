module TopModule (
    input wire a,       // 1-bit input signal 'a'
    input wire b,       // 1-bit input signal 'b'
    output wire out_and,  // 1-bit output for the AND operation
    output wire out_or,   // 1-bit output for the OR operation
    output wire out_xor,  // 1-bit output for the XOR operation
    output wire out_nand, // 1-bit output for the NAND operation
    output wire out_nor,  // 1-bit output for the NOR operation
    output wire out_xnor, // 1-bit output for the XNOR operation
    output wire out_anotb // 1-bit output for the AND-NOT operation
);

    // Combinational logic for each operation
    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;

endmodule