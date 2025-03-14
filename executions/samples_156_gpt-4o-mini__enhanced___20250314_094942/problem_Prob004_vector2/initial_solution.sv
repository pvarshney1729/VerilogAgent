module TopModule (
    input logic [31:0] in,         // 32-bit input vector, unsigned
    output logic [31:0] out        // 32-bit output vector, unsigned
);

always @(*) begin
    out[31:24] = in[7:0];    // First byte becomes last
    out[23:16] = in[15:8];   // Second byte becomes third
    out[15:8]  = in[23:16];  // Third byte becomes second
    out[7:0]   = in[31:24];  // Last byte becomes first
end

endmodule