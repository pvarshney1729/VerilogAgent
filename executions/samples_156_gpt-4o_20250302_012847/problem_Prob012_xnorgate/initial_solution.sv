module xnor_gate (
    input logic a,
    input logic b,
    output logic y
);

    // Combinational logic for XNOR gate
    assign y = ~(a ^ b);

endmodule