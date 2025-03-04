module TopModule (
    input  wire [2:0] a,              // 3-bit input vector a
    input  wire [2:0] b,              // 3-bit input vector b
    output wire [2:0] out_or_bitwise, // 3-bit output for bitwise OR operation
    output wire       out_or_logical, // 1-bit output for logical OR operation
    output wire [5:0] out_not         // 6-bit output for NOT operations
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = |a | |b;

    // Inverse operation
    assign out_not[2:0] = ~a;
    assign out_not[5:3] = ~b;

endmodule