module TopModule (
    input logic [7:0] in,     // 8-bit input (unsigned)
    output logic [7:0] out     // 8-bit output (unsigned)
);

always @(*) begin
    // Bit reversal logic
    out[0] = in[7]; // LSB of 'out' is MSB of 'in'
    out[1] = in[6];
    out[2] = in[5];
    out[3] = in[4];
    out[4] = in[3];
    out[5] = in[2];
    out[6] = in[1];
    out[7] = in[0]; // MSB of 'out' is LSB of 'in'
end

endmodule