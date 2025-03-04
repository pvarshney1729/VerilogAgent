module TopModule (
    input  [3:0] x,
    input  [3:0] y,
    output [4:0] sum
);

    logic [3:0] carry;
    logic [3:0] sum_bits;

    // Full Adder for bit 0
    assign sum_bits[0] = x[0] ^ y[0];
    assign carry[0] = x[0] & y[0];

    // Full Adder for bit 1
    assign sum_bits[1] = x[1] ^ y[1] ^ carry[0];
    assign carry[1] = (x[1] & y[1]) | (x[1] & carry[0]) | (y[1] & carry[0]);

    // Full Adder for bit 2
    assign sum_bits[2] = x[2] ^ y[2] ^ carry[1];
    assign carry[2] = (x[2] & y[2]) | (x[2] & carry[1]) | (y[2] & carry[1]);

    // Full Adder for bit 3
    assign sum_bits[3] = x[3] ^ y[3] ^ carry[2];
    assign carry[3] = (x[3] & y[3]) | (x[3] & carry[2]) | (y[3] & carry[2]);

    // Combine sum bits and final carry-out
    assign sum = {carry[3], sum_bits};

endmodule