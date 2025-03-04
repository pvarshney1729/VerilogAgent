module TopModule(
    input  logic [3:0] x,    // 4-bit input; bit[3] is the most significant bit (MSB), bit[0] is the least significant bit (LSB)
    input  logic [3:0] y,    // 4-bit input; bit[3] is the MSB, bit[0] is the LSB
    output logic [4:0] sum   // 5-bit output; sum[4] is the overflow bit (carry out), sum[3:0] represents the 4-bit sum result
);

    assign sum = x + y; // Perform 4-bit addition, result is 5 bits to include overflow

endmodule