module TopModule (
    input  logic [3:0] x,
    input  logic [3:0] y,
    output logic [4:0] sum
);
    logic c1, c2, c3; // Carry bits between full adders
    logic sum0, sum1, sum2, sum3; // Sum outputs from full adders

    // First full adder
    FullAdder FA0 (
        .x(x[0]),
        .y(y[0]),
        .cin(1'b0),
        .sum(sum0),
        .cout(c1)
    );

    // Second full adder
    FullAdder FA1 (
        .x(x[1]),
        .y(y[1]),
        .cin(c1),
        .sum(sum1),
        .cout(c2)
    );

    // Third full adder
    FullAdder FA2 (
        .x(x[2]),
        .y(y[2]),
        .cin(c2),
        .sum(sum2),
        .cout(c3)
    );

    // Fourth full adder
    FullAdder FA3 (
        .x(x[3]),
        .y(y[3]),
        .cin(c3),
        .sum(sum3),
        .cout(sum[4]) // Overflow bit
    );

    // Combine the sum outputs
    assign sum[3:0] = {sum3, sum2, sum1, sum0};

endmodule

module FullAdder (
    input logic x,
    input logic y,
    input logic cin,
    output logic sum,
    output logic cout
);
    assign sum = x ^ y ^ cin;      // Sum is the XOR of x, y, and carry-in
    assign cout = (x & y) | (cin & (x ^ y)); // Carry-out logic
endmodule