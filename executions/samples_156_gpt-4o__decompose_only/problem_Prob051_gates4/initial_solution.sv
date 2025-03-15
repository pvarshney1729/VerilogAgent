module TopModule (
    input  [3:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);

    // Implementing a 4-input AND gate
    assign out_and = &in;

    // Implementing a 4-input OR gate
    assign out_or = |in;

    // Implementing a 4-input XOR gate
    assign out_xor = ^in;

endmodule