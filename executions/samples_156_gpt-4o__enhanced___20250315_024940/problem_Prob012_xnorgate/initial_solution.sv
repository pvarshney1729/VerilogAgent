module TopModule (
    input logic a,
    input logic b,
    output logic out
);

    // Implementing the XNOR operation
    assign out = ~(a ^ b);

endmodule