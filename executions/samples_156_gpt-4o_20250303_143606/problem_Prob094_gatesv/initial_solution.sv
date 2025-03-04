module TopModule (
    input  wire [3:0] in,          // 4-bit input vector, bit[3] is MSB, bit[0] is LSB
    output wire [3:0] out_both,    // 4-bit output vector, unsigned
    output wire [3:0] out_any,     // 4-bit output vector, unsigned
    output wire [3:0] out_different // 4-bit output vector, unsigned
);

    assign out_both[3] = 1'b0;
    assign out_both[2:0] = in[2:0] & in[3:1];

    assign out_any[0] = 1'b0;
    assign out_any[3:1] = in[3:1] | in[2:0];

    assign out_different[3:0] = {in[3] ^ in[0], in[2:0] ^ in[3:1]};

endmodule