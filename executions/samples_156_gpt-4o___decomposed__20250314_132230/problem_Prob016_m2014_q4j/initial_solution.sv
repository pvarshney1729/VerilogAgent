module TopModule(
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    logic c1, c2, c3, c4;

    // Full adder instances
    full_adder FA0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0),
        .sum(sum[0]),
        .cout(c1)
    );

    full_adder FA1 (
        .a(x[1]),
        .b(y[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    full_adder FA2 (
        .a(x[2]),
        .b(y[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    full_adder FA3 (
        .a(x[3]),
        .b(y[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(c4)
    );

    assign sum[4] = c4; // Overflow bit

endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule