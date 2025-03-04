module TopModule (
    input logic a,  // 1-bit input, unsigned
    input logic b,  // 1-bit input, unsigned
    input logic c,  // 1-bit input, unsigned
    output logic w, // 1-bit output, unsigned
    output logic x, // 1-bit output, unsigned
    output logic y, // 1-bit output, unsigned
    output logic z  // 1-bit output, unsigned
);

assign w = a;
assign x = b;
assign y = b;
assign z = c;

endmodule