module FullAdder (
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module TopModule (
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [4:0] sum
);
    logic carry[3:0]; // Intermediate carry signals

    FullAdder FA0 (
        .a(x[0]),
        .b(y[0]),
        .cin(1'b0), // No initial carry
        .sum(sum[0]),
        .cout(carry[0])
    );

    FullAdder FA1 (
        .a(x[1]),
        .b(y[1]),
        .cin(carry[0]), // Carry from the previous stage
        .sum(sum[1]),
        .cout(carry[1])
    );

    FullAdder FA2 (
        .a(x[2]),
        .b(y[2]),
        .cin(carry[1]), // Carry from the previous stage
        .sum(sum[2]),
        .cout(carry[2])
    );

    FullAdder FA3 (
        .a(x[3]),
        .b(y[3]),
        .cin(carry[2]), // Carry from the previous stage
        .sum(sum[3]),
        .cout(sum[4])   // Overflow bit
    );
endmodule