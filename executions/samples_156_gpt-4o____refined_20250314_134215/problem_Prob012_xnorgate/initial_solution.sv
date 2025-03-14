module TopModule (
    input  logic a,
    input  logic b,
    output logic out
);

    // Implementing XNOR gate
    assign out = ~(a ^ b);

endmodule