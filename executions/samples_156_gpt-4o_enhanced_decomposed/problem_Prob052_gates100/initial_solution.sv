module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for 100-input AND gate
    assign out_and = &in;

    // Combinational logic for 100-input OR gate
    assign out_or = |in;

    // Combinational logic for 100-input XOR gate
    assign out_xor = ^in;

endmodule