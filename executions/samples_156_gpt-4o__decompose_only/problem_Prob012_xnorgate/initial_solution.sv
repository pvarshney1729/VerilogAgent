module TopModule (
    input  logic a,
    input  logic b,
    output logic out
);

    // Implementing XNOR logic
    assign out = ~(a ^ b);

endmodule