module TopModule (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

    // Combinational logic for out_and
    assign out_and = &in;

    // Combinational logic for out_or
    assign out_or = |in;

    // Combinational logic for out_xor
    assign out_xor = ^in;

endmodule