module TopModule (
    input logic x3,  // 1-bit input, unsigned
    input logic x2,  // 1-bit input, unsigned
    input logic x1,  // 1-bit input, unsigned
    output logic f   // 1-bit output, unsigned
);

    always @(*) begin
        f = (x2 & ~x3) | (x1 & x3);
    end

endmodule