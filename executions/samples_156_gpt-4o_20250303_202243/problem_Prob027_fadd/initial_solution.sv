module TopModule (
    input logic a,    // 1-bit input
    input logic b,    // 1-bit input
    input logic cin,  // 1-bit carry-in input
    output logic cout, // 1-bit carry-out output
    output logic sum   // 1-bit sum output
);

    // Combinational logic for full adder
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule