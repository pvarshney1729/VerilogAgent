module TopModule (
    input logic a,  // Single-bit input, active-high
    input logic b,  // Single-bit input, active-high
    output logic out // Single-bit output, active-high
);

    // Combinational logic for NOR gate
    assign out = ~(a | b);

endmodule