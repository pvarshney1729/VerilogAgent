module TopModule (
    input logic a,    // 1-bit input, unsigned
    input logic b,    // 1-bit input, unsigned
    output logic out_and,   // 1-bit output, result of logical AND
    output logic out_or,    // 1-bit output, result of logical OR
    output logic out_xor,   // 1-bit output, result of logical XOR
    output logic out_nand,  // 1-bit output, result of logical NAND
    output logic out_nor,   // 1-bit output, result of logical NOR
    output logic out_xnor,  // 1-bit output, result of logical XNOR
    output logic out_anotb  // 1-bit output, result of logical (a AND (NOT b))
);

    // Combinational logic for each output
    always_comb begin
        out_and = a & b;
        out_or = a | b;
        out_xor = a ^ b;
        out_nand = ~(a & b);
        out_nor = ~(a | b);
        out_xnor = ~(a ^ b);
        out_anotb = a & ~b;
    end

endmodule