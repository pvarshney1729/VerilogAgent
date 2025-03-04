module TopModule (
    input logic a, // Single-bit input, unsigned
    input logic b, // Single-bit input, unsigned
    input logic c, // Single-bit input, unsigned
    input logic d, // Single-bit input, unsigned
    output logic q // Single-bit output, unsigned
);

    // Combinational logic to determine the output q
    assign q = (b & c) | (c & d) | (b & d);

endmodule