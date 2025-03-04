module TopModule(
    input logic a, // 1-bit input, unsigned
    input logic b, // 1-bit input, unsigned
    input logic c, // 1-bit input, unsigned
    input logic d, // 1-bit input, unsigned
    output logic out // 1-bit output, unsigned
);

    // Combinational logic derived from the Karnaugh map
    assign out = (~c & ~d & ~b) | (~c & ~d & a) | (~c & d & ~a) | (c & ~d & b) | (c & d);

endmodule