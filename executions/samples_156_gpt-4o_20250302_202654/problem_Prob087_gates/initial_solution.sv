module TopModule(
    input logic a,  // Single-bit input signal
    input logic b,  // Single-bit input signal
    output logic out_and,   // Single-bit output for AND operation: a AND b
    output logic out_or,    // Single-bit output for OR operation: a OR b
    output logic out_xor,   // Single-bit output for XOR operation: a XOR b
    output logic out_nand,  // Single-bit output for NAND operation: a NAND b
    output logic out_nor,   // Single-bit output for NOR operation: a NOR b
    output logic out_xnor,  // Single-bit output for XNOR operation: a XNOR b
    output logic out_a_and_not_b // Single-bit output for AND-NOT operation: a AND (NOT b)
);

    // Combinational logic for each output
    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_a_and_not_b = a & ~b;

endmodule