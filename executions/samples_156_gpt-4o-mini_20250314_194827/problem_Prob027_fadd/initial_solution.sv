module TopModule (
    input logic a,    // Single-bit input representing the first operand
    input logic b,    // Single-bit input representing the second operand
    input logic cin,  // Single-bit input representing the carry-in
    output logic cout, // Single-bit output representing the carry-out
    output logic sum   // Single-bit output representing the sum of inputs
);

    assign sum = a ^ b ^ cin; // Calculate sum
    assign cout = (a & b) | (b & cin) | (a & cin); // Calculate carry-out

endmodule