module TopModule(
    input logic a,
    input logic b,
    output logic out
);

    // Implementing the XNOR gate using an assign statement
    assign out = ~(a ^ b);

endmodule