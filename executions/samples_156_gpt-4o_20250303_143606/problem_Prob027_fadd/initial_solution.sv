module TopModule(
    input wire a,
    input wire b,
    input wire cin,
    output wire cout,
    output wire sum
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule