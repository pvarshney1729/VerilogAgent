module TopModule (
    input logic a,    // One-bit input signal
    input logic b,    // One-bit input signal
    input logic sel,  // One-bit select signal to choose between inputs `a` and `b`
    output logic out  // One-bit output signal reflecting the selected input
);

    // Implementing the 2-to-1 multiplexer using a conditional operator
    assign out = sel ? b : a;

endmodule