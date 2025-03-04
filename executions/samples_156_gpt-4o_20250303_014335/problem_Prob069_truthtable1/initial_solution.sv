module TopModule (
    input  wire x3, // 1-bit input
    input  wire x2, // 1-bit input
    input  wire x1, // 1-bit input
    output wire f   // 1-bit output
);

    assign f = (x2 & ~x3) | (x1 & x3) | (x1 & x2);

endmodule