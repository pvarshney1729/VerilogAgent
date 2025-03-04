module TopModule (
    input  logic a,       // 1-bit input signal
    input  logic b,       // 1-bit input signal
    output logic out_and, // 1-bit output for AND operation
    output logic out_or,  // 1-bit output for OR operation
    output logic out_xor, // 1-bit output for XOR operation
    output logic out_nand,// 1-bit output for NAND operation
    output logic out_nor, // 1-bit output for NOR operation
    output logic out_xnor,// 1-bit output for XNOR operation
    output logic out_a_not_b // 1-bit output for A AND NOT B operation
);

    // Combinational logic for each output
    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_a_not_b = a & ~b;

endmodule