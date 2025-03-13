module TopModule (
    input logic [7:0] data_in,  // 8-bit input data
    output logic parity          // 1-bit output for even parity
);

always @(*) begin
    parity = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^
             data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
end

endmodule