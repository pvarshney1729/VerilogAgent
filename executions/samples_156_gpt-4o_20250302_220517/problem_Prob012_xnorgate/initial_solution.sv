module TopModule (
    input logic a,
    input logic b,
    output logic out
);

    // Implementing the XNOR logic
    assign out = a ~^ b;

endmodule