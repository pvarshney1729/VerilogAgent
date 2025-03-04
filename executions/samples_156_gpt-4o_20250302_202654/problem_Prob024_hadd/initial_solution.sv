module HalfAdder (
    input wire a,     // 1-bit input, unsigned
    input wire b,     // 1-bit input, unsigned
    output wire sum,  // 1-bit output, result of a XOR b
    output wire cout  // 1-bit output, result of a AND b
);

    // Combinational logic for sum and carry-out
    assign sum = a ^ b;  // XOR operation for sum
    assign cout = a & b; // AND operation for carry-out

endmodule