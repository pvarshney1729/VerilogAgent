module TopModule(
    input logic a,    // Single-bit input
    input logic b,    // Single-bit input
    output logic sum, // Single-bit output
    output logic cout // Single-bit output
);

    // Combinational logic for half adder
    assign sum = a ^ b;   // XOR operation for sum
    assign cout = a & b;  // AND operation for carry-out

endmodule