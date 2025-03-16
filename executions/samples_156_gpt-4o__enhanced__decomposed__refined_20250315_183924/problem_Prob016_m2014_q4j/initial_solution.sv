module TopModule (
    input  wire [3:0] x,    // 4-bit input vector x
    input  wire [3:0] y,    // 4-bit input vector y
    output wire [4:0] sum   // 5-bit output vector sum
);
    wire c1, c2, c3; // Intermediate carry wires

    // Full adder for bit 0
    assign {c1, sum[0]} = x[0] + y[0];

    // Full adder for bit 1
    assign {c2, sum[1]} = x[1] + y[1] + c1;

    // Full adder for bit 2
    assign {c3, sum[2]} = x[2] + y[2] + c2;

    // Full adder for bit 3
    assign {sum[4], sum[3]} = x[3] + y[3] + c3;

endmodule