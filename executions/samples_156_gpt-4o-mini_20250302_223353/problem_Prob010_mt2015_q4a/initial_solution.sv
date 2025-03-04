module TopModule (
    input logic x,  // 1-bit input signal
    input logic y,  // 1-bit input signal
    output logic z  // 1-bit output signal
);

    assign z = (x ^ y) & x;  // z = (x XOR y) AND x

endmodule