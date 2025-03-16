module TopModule (
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for 4-input AND gate
    assign out_and = &in;

    // Combinational logic for 4-input OR gate
    assign out_or = |in;

    // Combinational logic for 4-input XOR gate
    assign out_xor = ^in;

endmodule