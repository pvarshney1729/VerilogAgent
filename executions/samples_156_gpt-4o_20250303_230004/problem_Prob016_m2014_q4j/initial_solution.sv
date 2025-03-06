module TopModule(
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    logic [3:0] carry;
    logic [3:0] result;

    // Full adder for bit 0
    assign result[0] = x[0] ^ y[0];
    assign carry[0] = x[0] & y[0];

    // Full adder for bit 1
    assign result[1] = x[1] ^ y[1] ^ carry[0];
    assign carry[1] = (x[1] & y[1]) | (x[1] & carry[0]) | (y[1] & carry[0]);

    // Full adder for bit 2
    assign result[2] = x[2] ^ y[2] ^ carry[1];
    assign carry[2] = (x[2] & y[2]) | (x[2] & carry[1]) | (y[2] & carry[1]);

    // Full adder for bit 3
    assign result[3] = x[3] ^ y[3] ^ carry[2];
    assign carry[3] = (x[3] & y[3]) | (x[3] & carry[2]) | (y[3] & carry[2]);

    // Assign the result and overflow
    assign sum[3:0] = result;
    assign sum[4] = carry[3];

endmodule