module TopModule (
    input  [3:0] x,  // 4-bit input, unsigned
    input  [3:0] y,  // 4-bit input, unsigned
    output [4:0] sum // 5-bit output, includes overflow
);

    wire carry1, carry2, carry3;

    // Full Adder for bit 0
    assign {carry1, sum[0]} = x[0] + y[0];

    // Full Adder for bit 1
    assign {carry2, sum[1]} = x[1] + y[1] + carry1;

    // Full Adder for bit 2
    assign {carry3, sum[2]} = x[2] + y[2] + carry2;

    // Full Adder for bit 3
    assign {sum[4], sum[3]} = x[3] + y[3] + carry3;

endmodule