module TopModule (
    input logic a,          // 1-bit input signal
    input logic b,          // 1-bit input signal
    output logic out_and,   // 1-bit output: result of AND operation between a and b
    output logic out_or,    // 1-bit output: result of OR operation between a and b
    output logic out_xor,   // 1-bit output: result of XOR operation between a and b
    output logic out_nand,  // 1-bit output: result of NAND operation between a and b
    output logic out_nor,   // 1-bit output: result of NOR operation between a and b
    output logic out_xnor,  // 1-bit output: result of XNOR operation between a and b
    output logic out_anotb   // 1-bit output: result of AND operation between a and NOT b
);

    assign out_and = a & b; 
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b; // AND operation between a and the complement of b

endmodule