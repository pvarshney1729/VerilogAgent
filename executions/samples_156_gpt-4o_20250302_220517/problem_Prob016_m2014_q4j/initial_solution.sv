module TopModule(
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);

    logic [3:0] carry;

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