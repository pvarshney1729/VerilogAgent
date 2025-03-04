module TopModule (
    input logic x,  // 1-bit input signal, unsigned
    input logic y,  // 1-bit input signal, unsigned
    output logic z  // 1-bit output signal, unsigned
);

    assign z = (x ^ y) & x;

endmodule