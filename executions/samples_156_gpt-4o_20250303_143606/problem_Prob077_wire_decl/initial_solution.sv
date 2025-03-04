module TopModule (
    input logic a,    // Single-bit input, unsigned
    input logic b,    // Single-bit input, unsigned
    input logic c,    // Single-bit input, unsigned
    input logic d,    // Single-bit input, unsigned
    output logic out, // Single-bit output, result of OR operation
    output logic out_n // Single-bit output, inverted `out`
);

    logic and1_out; // Intermediate wire for the output of the first AND gate
    logic and2_out; // Intermediate wire for the output of the second AND gate

    // First Layer (AND Gates)
    assign and1_out = a & b; // AND gate with inputs `a` and `b`
    assign and2_out = c & d; // AND gate with inputs `c` and `d`

    // Second Layer (OR Gate and NOT Gate)
    assign out = and1_out | and2_out; // OR gate combining outputs of AND gates
    assign out_n = ~out; // NOT gate inverts the `out` signal

endmodule