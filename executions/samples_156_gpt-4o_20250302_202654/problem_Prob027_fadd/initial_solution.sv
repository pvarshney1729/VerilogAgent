module TopModule(
    input wire a,
    input wire b,
    input wire cin,
    output wire cout,
    output wire sum
);

    // Combinational logic for sum and carry-out
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule