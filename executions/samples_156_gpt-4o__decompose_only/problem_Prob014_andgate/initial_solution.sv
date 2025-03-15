module TopModule (
    input  logic a,
    input  logic b,
    output logic out
);

    // Implementing a 2-input AND gate
    assign out = a & b;

endmodule