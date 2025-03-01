module TopModule (
    input wire a,  // 1-bit unsigned input
    input wire b,  // 1-bit unsigned input
    input wire c,  // 1-bit unsigned input
    input wire d,  // 1-bit unsigned input
    output wire q  // 1-bit unsigned output
);

    assign q = (b | c) | (c & d);

endmodule