[BEGIN]
module TopModule(
    input  logic a,      // Single-bit input signal
    input  logic b,      // Single-bit input signal
    output logic out_and,    // Output of 'a and b'
    output logic out_or,     // Output of 'a or b'
    output logic out_xor,    // Output of 'a xor b'
    output logic out_nand,   // Output of 'a nand b'
    output logic out_nor,    // Output of 'a nor b'
    output logic out_xnor,   // Output of 'a xnor b'
    output logic out_anotb   // Output of 'a and-not b'
);

always @(*) begin
    out_and = a & b;
    out_or = a | b;
    out_xor = a ^ b;
    out_nand = ~(a & b);
    out_nor = ~(a | b);
    out_xnor = ~(a ^ b);
    out_anotb = a & ~b;
end

endmodule
[DONE]