module TopModule (
    input  [2:0] a,             // 3-bit input vector 'a'
    input  [2:0] b,             // 3-bit input vector 'b'
    output [2:0] out_or_bitwise,// 3-bit output for bitwise OR of 'a' and 'b'
    output       out_or_logical,// 1-bit output for logical OR of 'a' and 'b'
    output [5:0] out_not        // 6-bit output, upper 3 bits are NOT 'b', lower 3 bits are NOT 'a'
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = (a != 3'b000) || (b != 3'b000);

    // Bitwise NOT operation
    assign out_not = {~b, ~a};

endmodule