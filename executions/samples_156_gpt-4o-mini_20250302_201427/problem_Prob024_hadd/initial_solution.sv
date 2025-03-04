module TopModule (
    input logic a,      // Single bit input
    input logic b,      // Single bit input
    output logic sum,   // Single bit sum output
    output logic cout   // Single bit carry-out output
);

    assign sum = a ^ b;  // Sum logic: a XOR b
    assign cout = a & b; // Carry-out logic: a AND b

endmodule