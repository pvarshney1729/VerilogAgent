module TopModule(
    input logic a,
    input logic b,
    output logic out
);

    // Implementing an XNOR gate
    assign out = ~(a ^ b);

endmodule