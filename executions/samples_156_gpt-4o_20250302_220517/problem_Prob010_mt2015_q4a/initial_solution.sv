module TopModule (
    input wire x, // 1-bit input signal, representing the first operand in the boolean function.
    input wire y, // 1-bit input signal, representing the second operand in the boolean function.
    output wire z // 1-bit output signal, representing the result of the boolean function (x XOR y) AND x.
);

    // Implement the logic for z = (x XOR y) AND x
    assign z = (x ^ y) & x;

endmodule