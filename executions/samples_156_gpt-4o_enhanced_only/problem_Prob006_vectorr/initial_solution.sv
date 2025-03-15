module TopModule(
    input logic [7:0] in,    // 8-bit input
    output logic [7:0] out   // 8-bit output
);

    always @(*) begin
        // Reverse the bit ordering of 'in' and assign to 'out'
        out[7] = in[0];
        out[6] = in[1];
        out[5] = in[2];
        out[4] = in[3];
        out[3] = in[4];
        out[2] = in[5];
        out[1] = in[6];
        out[0] = in[7];
    end

endmodule