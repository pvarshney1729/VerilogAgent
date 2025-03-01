module TopModule(
    input wire a,
    input wire b,
    input wire cin,
    output wire cout,
    output wire sum
);

    // Sum calculation using XOR
    assign sum = a ^ b ^ cin;

    // Carry-out calculation using AND and OR
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule