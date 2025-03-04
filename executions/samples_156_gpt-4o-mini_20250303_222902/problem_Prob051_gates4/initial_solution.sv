module TopModule(
    logic [3:0] in,
    logic out_and,
    logic out_or,
    logic out_xor
);
    assign out_and = &in;        // Bitwise AND reduction
    assign out_or  = |in;        // Bitwise OR reduction
    assign out_xor = ^in;        // Bitwise XOR reduction
endmodule