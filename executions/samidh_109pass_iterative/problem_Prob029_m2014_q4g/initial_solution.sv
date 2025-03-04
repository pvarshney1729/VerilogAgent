module TopModule (
    input  wire in1,  // 1-bit input, unsigned
    input  wire in2,  // 1-bit input, unsigned
    input  wire in3,  // 1-bit input, unsigned
    output wire out   // 1-bit output, unsigned
);

    assign out = ~((in1 ^ in2) ^ in3);

endmodule