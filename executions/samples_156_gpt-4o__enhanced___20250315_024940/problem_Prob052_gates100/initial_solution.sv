module TopModule (
    input logic [99:0] in,   // 100-bit input
    output logic out_and,    // Output of 100-input AND gate
    output logic out_or,     // Output of 100-input OR gate
    output logic out_xor     // Output of 100-input XOR gate
);

    // Assignments for combinational logic
    assign out_and = &in;          // AND operation on all bits
    assign out_or = |in;           // OR operation on all bits
    assign out_xor = ^in;          // XOR operation on all bits

endmodule