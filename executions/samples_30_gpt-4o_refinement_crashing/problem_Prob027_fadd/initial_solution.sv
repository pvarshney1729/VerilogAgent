module TopModule(
    input logic a,
    input logic b,
    input logic cin,
    output logic cout,
    output logic sum
);

    // Calculate sum using XOR operation
    assign sum = a ^ b ^ cin;

    // Calculate carry-out using OR and AND operations
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule