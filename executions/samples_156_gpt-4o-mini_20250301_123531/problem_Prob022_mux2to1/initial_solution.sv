module TopModule (
    input logic a,  // 1-bit input signal representing the first data input.
    input logic b,  // 1-bit input signal representing the second data input.
    input logic sel, // 1-bit input signal used to select between a and b.
    output logic out // 1-bit output signal representing the selected data input.
);

    assign out = sel ? b : a;

endmodule