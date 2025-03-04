module TopModule(
    input [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for AND, OR, and XOR operations
    assign out_and = &in;  // AND reduction operator
    assign out_or = |in;   // OR reduction operator
    assign out_xor = ^in;  // XOR reduction operator

endmodule