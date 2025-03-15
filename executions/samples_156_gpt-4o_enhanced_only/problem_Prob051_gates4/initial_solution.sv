module TopModule(
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for the outputs
    assign out_and = &in;   // 4-input AND operation
    assign out_or  = |in;   // 4-input OR operation
    assign out_xor = ^in;   // 4-input XOR operation

endmodule