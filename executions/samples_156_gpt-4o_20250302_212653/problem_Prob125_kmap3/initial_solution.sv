module TopModule (
    input logic a,  // 1-bit unsigned input
    input logic b,  // 1-bit unsigned input
    input logic c,  // 1-bit unsigned input
    input logic d,  // 1-bit unsigned input
    output logic out  // 1-bit unsigned output
);

    // Combinational logic derived from the simplified expression
    assign out = (a & c) | (b & c) | (a & b);

endmodule