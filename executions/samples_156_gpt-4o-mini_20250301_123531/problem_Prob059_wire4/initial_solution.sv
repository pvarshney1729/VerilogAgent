module TopModule (
    input logic a, // Single-bit input signal `a`.
    input logic b, // Single-bit input signal `b`.
    input logic c, // Single-bit input signal `c`.
    output logic w, // Single-bit output signal `w`, directly connected to input `a`.
    output logic x, // Single-bit output signal `x`, directly connected to input `b`.
    output logic y, // Single-bit output signal `y`, directly connected to input `b`.
    output logic z  // Single-bit output signal `z`, directly connected to input `c`.
);

assign w = a; // Direct connection from input `a` to output `w`.
assign x = b; // Direct connection from input `b` to output `x`.
assign y = b; // Direct connection from input `b` to output `y`.
assign z = c; // Direct connection from input `c` to output `z`.

endmodule