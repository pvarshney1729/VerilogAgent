module TopModule(
    input wire [99:0] in,
    output wire out_and,
    output wire out_or,
    output wire out_xor
);

    assign out_and = &in; // AND reduction operator
    assign out_or = |in;  // OR reduction operator
    assign out_xor = ^in; // XOR reduction operator

endmodule