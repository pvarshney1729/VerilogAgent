module TopModule(
    input logic [7:0] in,
    output logic parity
);

    // Combinational logic to calculate even parity
    always @(*) begin
        parity = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
    end

endmodule