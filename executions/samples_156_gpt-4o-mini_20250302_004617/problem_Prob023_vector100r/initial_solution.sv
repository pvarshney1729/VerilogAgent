module reverse_100bit (
    input logic [99:0] in_vector,
    output logic [99:0] out_vector
);

    always @(*) begin
        out_vector = {in_vector[0], in_vector[1], in_vector[2], in_vector[3], in_vector[4],
                      in_vector[5], in_vector[6], in_vector[7], in_vector[8], in_vector[9],
                      in_vector[10], in_vector[11], in_vector[12], in_vector[13], in_vector[14],
                      in_vector[15], in_vector[16], in_vector[17], in_vector[18], in_vector[19],
                      in_vector[20], in_vector[21], in_vector[22], in_vector[23], in_vector[24],
                      in_vector[25], in_vector[26], in_vector[27], in_vector[28], in_vector[29],
                      in_vector[30], in_vector[31], in_vector[32], in_vector[33], in_vector[34],
                      in_vector[35], in_vector[36], in_vector[37], in_vector[38], in_vector[39],
                      in_vector[40], in_vector[41], in_vector[42], in_vector[43], in_vector[44],
                      in_vector[45], in_vector[46], in_vector[47], in_vector[48], in_vector[49],
                      in_vector[50], in_vector[51], in_vector[52], in_vector[53], in_vector[54],
                      in_vector[55], in_vector[56], in_vector[57], in_vector[58], in_vector[59],
                      in_vector[60], in_vector[61], in_vector[62], in_vector[63], in_vector[64],
                      in_vector[65], in_vector[66], in_vector[67], in_vector[68], in_vector[69],
                      in_vector[70], in_vector[71], in_vector[72], in_vector[73], in_vector[74],
                      in_vector[75], in_vector[76], in_vector[77], in_vector[78], in_vector[79],
                      in_vector[80], in_vector[81], in_vector[82], in_vector[83], in_vector[84],
                      in_vector[85], in_vector[86], in_vector[87], in_vector[88], in_vector[89],
                      in_vector[90], in_vector[91], in_vector[92], in_vector[93], in_vector[94],
                      in_vector[95], in_vector[96], in_vector[97], in_vector[98], in_vector[99]};
    end

endmodule