module TopModule (
    input wire a,     // Single-bit input
    input wire b,     // Single-bit input
    input wire cin,   // Single-bit carry-in input
    output wire cout, // Single-bit carry-out output
    output wire sum   // Single-bit sum output
);

    // Combinational logic for full adder
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule