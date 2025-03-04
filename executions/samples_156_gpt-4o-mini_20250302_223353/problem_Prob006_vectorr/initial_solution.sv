module TopModule (
    input  logic [7:0] in,  // 8-bit input vector
    output logic [7:0] out  // 8-bit output vector
);
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
endmodule