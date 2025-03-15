module TopModule (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);

    // Half adder logic
    assign sum  = a ^ b;  // Sum is the XOR of inputs
    assign cout = a & b;  // Carry-out is the AND of inputs

endmodule