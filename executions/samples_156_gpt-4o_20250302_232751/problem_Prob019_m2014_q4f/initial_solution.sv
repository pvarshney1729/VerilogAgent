module TopModule (
    input wire in1,  // 1-bit, unsigned
    input wire in2,  // 1-bit, unsigned
    output wire out  // 1-bit, unsigned
);

    // Combinational logic for out = in1 AND NOT(in2)
    assign out = in1 & ~in2;

endmodule