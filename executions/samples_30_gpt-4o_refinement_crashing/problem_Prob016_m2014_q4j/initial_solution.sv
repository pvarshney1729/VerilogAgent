module FullAdder(
    input  logic a,
    input  logic b,
    input  logic cin,
    output logic sum,
    output logic cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module TopModule(
    input  logic [3:0] x,
    input  logic [3:0] y,
    output logic [4:0] sum
);
    logic c0, c1, c2, c3;

    // Instantiate full adders
    FullAdder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(c0));
    FullAdder fa1 (.a(x[1]), .b(y[1]), .cin(c0), .sum(sum[1]), .cout(c1));
    FullAdder fa2 (.a(x[2]), .b(y[2]), .cin(c1), .sum(sum[2]), .cout(c2));
    FullAdder fa3 (.a(x[3]), .b(y[3]), .cin(c2), .sum(sum[3]), .cout(c3));

    // Assign the final carry-out as the overflow bit
    assign sum[4] = c3;
endmodule