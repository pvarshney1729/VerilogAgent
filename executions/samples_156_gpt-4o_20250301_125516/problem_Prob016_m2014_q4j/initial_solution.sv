module TopModule (
    input  logic [3:0] x,   // 4-bit input vector, bit[0] is LSB
    input  logic [3:0] y,   // 4-bit input vector, bit[0] is LSB
    output logic [4:0] sum  // 5-bit output vector, sum[0] is LSB, sum[4] is overflow
);

    logic [3:0] carry; // Internal carry signals

    // Full adder for bit 0
    assign {carry[0], sum[0]} = x[0] + y[0];

    // Full adder for bit 1
    assign {carry[1], sum[1]} = x[1] + y[1] + carry[0];

    // Full adder for bit 2
    assign {carry[2], sum[2]} = x[2] + y[2] + carry[1];

    // Full adder for bit 3
    assign {carry[3], sum[3]} = x[3] + y[3] + carry[2];

    // Overflow bit
    assign sum[4] = carry[3];

endmodule