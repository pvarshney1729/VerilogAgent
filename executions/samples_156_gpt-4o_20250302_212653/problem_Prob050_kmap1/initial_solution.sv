module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    output logic out // 1-bit output
);

    // Combinational logic derived from the Karnaugh map
    assign out = (~a & b) | (b & c);

endmodule