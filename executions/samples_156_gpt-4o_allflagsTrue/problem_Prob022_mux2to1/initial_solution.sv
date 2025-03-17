module TopModule(
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic out
);

    // Implementing the 2-to-1 multiplexer logic
    assign out = sel ? b : a;

endmodule