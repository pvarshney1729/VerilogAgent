module TopModule(
    input logic a,   // 1-bit input signal
    input logic b,   // 1-bit input signal
    input logic c,   // 1-bit input signal
    output logic w,  // 1-bit output signal
    output logic x,  // 1-bit output signal
    output logic y,  // 1-bit output signal
    output logic z   // 1-bit output signal
);

    // Direct wire connections for combinational logic
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule