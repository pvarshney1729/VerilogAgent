module TopModule (
    input wire a,   // 1-bit input, represents the first operand bit
    input wire b,   // 1-bit input, represents the second operand bit
    output wire sum, // 1-bit output, represents the sum of inputs a and b
    output wire cout // 1-bit output, represents the carry-out from the addition
);

    // Combinational logic for half adder
    assign sum = a ^ b;   // XOR operation for sum
    assign cout = a & b;  // AND operation for carry-out

endmodule