module TopModule (
    input logic x,   // Single-bit input signal x
    input logic y,   // Single-bit input signal y
    output logic z   // Single-bit output signal z
);

    // Combinational logic for z
    assign z = (x ^ y) & x;

endmodule