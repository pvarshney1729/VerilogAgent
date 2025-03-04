module TopModule(
    input logic a,  // Single-bit input signal
    input logic b,  // Single-bit input signal
    output logic out // Single-bit output signal representing the NOR operation result
);

    // Combinational logic for NOR operation
    assign out = ~(a | b);

endmodule