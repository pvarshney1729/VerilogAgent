module TopModule (
    input  logic [2:0] a,              // 3-bit input vector
    input  logic [2:0] b,              // 3-bit input vector
    output logic [2:0] out_or_bitwise, // 3-bit output vector for bitwise-OR
    output logic       out_or_logical, // 1-bit output for logical-OR
    output logic [5:0] out_not         // 6-bit output vector for NOT operations
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = |a || |b;

    // Bitwise NOT operation
    assign out_not = {~b, ~a};

endmodule