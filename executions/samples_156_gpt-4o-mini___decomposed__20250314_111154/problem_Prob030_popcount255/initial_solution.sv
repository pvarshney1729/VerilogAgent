module TopModule (
    input  logic [254:0] in,
    output logic [7:0] out
);

    logic [7:0] count;

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : count_group
            assign count[i] = in[i*32] + in[i*32 + 1] + in[i*32 + 2] + in[i*32 + 3] +
                              in[i*32 + 4] + in[i*32 + 5] + in[i*32 + 6] + in[i*32 + 7] +
                              in[i*32 + 8] + in[i*32 + 9] + in[i*32 + 10] + in[i*32 + 11] +
                              in[i*32 + 12] + in[i*32 + 13] + in[i*32 + 14] + in[i*32 + 15] +
                              in[i*32 + 16] + in[i*32 + 17] + in[i*32 + 18] + in[i*32 + 19] +
                              in[i*32 + 20] + in[i*32 + 21] + in[i*32 + 22] + in[i*32 + 23] +
                              in[i*32 + 24] + in[i*32 + 25] + in[i*32 + 26] + in[i*32 + 27] +
                              in[i*32 + 28] + in[i*32 + 29] + in[i*32 + 30] + in[i*32 + 31];
        end
    endgenerate

    assign out = count[0] + count[1] + count[2] + count[3] + count[4] + count[5] + count[6] + count[7];

endmodule