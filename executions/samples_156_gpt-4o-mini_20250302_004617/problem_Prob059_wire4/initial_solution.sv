module TopModule (
    input logic a,  // 1-bit input signal
    input logic b,  // 1-bit input signal
    input logic c,  // 1-bit input signal
    output logic w, // 1-bit output signal
    output logic x, // 1-bit output signal
    output logic y, // 1-bit output signal
    output logic z  // 1-bit output signal
);

    assign w = a; // w is directly connected to a
    assign x = b; // x is directly connected to b
    assign y = b; // y is directly connected to b
    assign z = c; // z is directly connected to c

endmodule