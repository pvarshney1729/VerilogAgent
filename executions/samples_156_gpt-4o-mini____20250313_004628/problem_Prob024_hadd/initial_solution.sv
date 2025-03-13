module TopModule (
    input  logic a,
    input  logic b,
    output logic sum,
    output logic cout
);

    assign sum = a ^ b;  // Sum is the XOR of a and b
    assign cout = a & b; // Carry-out is the AND of a and b

endmodule