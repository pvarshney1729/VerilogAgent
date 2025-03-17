module TopModule(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    // Calculate the sum using XOR
    assign sum = a ^ b ^ cin;

    // Calculate the carry-out using AND and OR
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule