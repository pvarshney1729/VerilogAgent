module TopModule (
    input logic a,  // Single-bit input
    input logic b,  // Single-bit input
    output logic out // Single-bit output
);

    // Combinational logic for NOR gate
    assign out = ~(a | b);

endmodule