module TopModule(
    input [7:0] data_in,
    output logic parity_out
);

    // Combinational logic to calculate even parity
    always @(*) begin
        parity_out = data_in[0] ^ data_in[1] ^ data_in[2] ^ data_in[3] ^
                     data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];
    end

endmodule