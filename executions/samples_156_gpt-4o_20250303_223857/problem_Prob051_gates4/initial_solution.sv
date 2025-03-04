module TopModule (
    input  logic [3:0] in,
    output logic       out_and,
    output logic       out_or,
    output logic       out_xor
);

    // Combinational logic for AND, OR, and XOR operations
    assign out_and = &in;  // AND all bits of the input
    assign out_or  = |in;  // OR all bits of the input
    assign out_xor = ^in;  // XOR all bits of the input

endmodule