module TopModule (
    input  logic [31:0] in,   // 32-bit input vector, treated as unsigned
    output logic [31:0] out   // 32-bit output vector, treated as unsigned
);

    // Combinational logic to reverse the byte order
    always @(*) begin
        out[31:24] = in[7:0];
        out[23:16] = in[15:8];
        out[15:8]  = in[23:16];
        out[7:0]   = in[31:24];
    end

endmodule