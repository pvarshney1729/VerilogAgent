module TopModule (
    input logic [7:0] in,   // 8-bit input
    output logic [7:0] out  // 8-bit output
);

always @(*) begin
    out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
end

endmodule