module TopModule (
    input wire a,
    input wire b,
    input wire cin,
    output wire cout,
    output wire sum
);
    // Full adder logic
    assign sum = a ^ b ^ cin;  // XOR operation for sum
    assign cout = (a & b) | (b & cin) | (cin & a);  // OR of ANDs for carry-out
endmodule