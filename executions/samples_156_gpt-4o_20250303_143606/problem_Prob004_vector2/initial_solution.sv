module TopModule (
    input [31:0] in,      // 32-bit wide input vector, unsigned
    output [31:0] out     // 32-bit wide output vector, unsigned
);

    // Combinational logic to reverse the byte order
    assign out = {in[7:0], in[15:8], in[23:16], in[31:24]};

endmodule