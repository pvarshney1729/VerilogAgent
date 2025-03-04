module TopModule (
    input logic a,     // Single-bit input: First operand
    input logic b,     // Single-bit input: Second operand
    input logic cin,   // Single-bit input: Carry-in from previous stage
    output logic cout, // Single-bit output: Carry-out to the next stage
    output logic sum   // Single-bit output: Sum of the three inputs
);

    // Combinational logic for sum and carry-out
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule