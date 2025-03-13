[BEGIN]
module TopModule(
    input  logic [99:0] input_bits,
    output logic [99:0] output_bits
);

    // Combinational logic to reverse the bit order
    always @(*) begin
        output_bits[0]  = input_bits[99];
        output_bits[1]  = input_bits[98];
        output_bits[2]  = input_bits[97];
        output_bits[3]  = input_bits[96];
        output_bits[4]  = input_bits[95];
        output_bits[5]  = input_bits[94];
        output_bits[6]  = input_bits[93];
        output_bits[7]  = input_bits[92];
        output_bits[8]  = input_bits[91];
        output_bits[9]  = input_bits[90];
        output_bits[10] = input_bits[89];
        output_bits[11] = input_bits[88];
        output_bits[12] = input_bits[87];
        output_bits[13] = input_bits[86];
        output_bits[14] = input_bits[85];
        output_bits[15] = input_bits[84];
        output_bits[16] = input_bits[83];
        output_bits[17] = input_bits[82];
        output_bits[18] = input_bits[81];
        output_bits[19] = input_bits[80];
        output_bits[20] = input_bits[79];
        output_bits[21] = input_bits[78];
        output_bits[22] = input_bits[77];
        output_bits[23] = input_bits[76];
        output_bits[24] = input_bits[75];
        output_bits[25] = input_bits[74];
        output_bits[26] = input_bits[73];
        output_bits[27] = input_bits[72];
        output_bits[28] = input_bits[71];
        output_bits[29] = input_bits[70];
        output_bits[30] = input_bits[69];
        output_bits[31] = input_bits[68];
        output_bits[32] = input_bits[67];
        output_bits[33] = input_bits[66];
        output_bits[34] = input_bits[65];
        output_bits[35] = input_bits[64];
        output_bits[36] = input_bits[63];
        output_bits[37] = input_bits[62];
        output_bits[38] = input_bits[61];
        output_bits[39] = input_bits[60];
        output_bits[40] = input_bits[59];
        output_bits[41] = input_bits[58];
        output_bits[42] = input_bits[57];
        output_bits[43] = input_bits[56];
        output_bits[44] = input_bits[55];
        output_bits[45] = input_bits[54];
        output_bits[46] = input_bits[53];
        output_bits[47] = input_bits[52];
        output_bits[48] = input_bits[51];
        output_bits[49] = input_bits[50];
        output_bits[50] = input_bits[49];
        output_bits[51] = input_bits[48];
        output_bits[52] = input_bits[47];
        output_bits[53] = input_bits[46];
        output_bits[54] = input_bits[45];
        output_bits[55] = input_bits[44];
        output_bits[56] = input_bits[43];
        output_bits[57] = input_bits[42];
        output_bits[58] = input_bits[41];
        output_bits[59] = input_bits[40];
        output_bits[60] = input_bits[39];
        output_bits[61] = input_bits[38];
        output_bits[62] = input_bits[37];
        output_bits[63] = input_bits[36];
        output_bits[64] = input_bits[35];
        output_bits[65] = input_bits[34];
        output_bits[66] = input_bits[33];
        output_bits[67] = input_bits[32];
        output_bits[68] = input_bits[31];
        output_bits[69] = input_bits[30];
        output_bits[70] = input_bits[29];
        output_bits[71] = input_bits[28];
        output_bits[72] = input_bits[27];
        output_bits[73] = input_bits[26];
        output_bits[74] = input_bits[25];
        output_bits[75] = input_bits[24];
        output_bits[76] = input_bits[23];
        output_bits[77] = input_bits[22];
        output_bits[78] = input_bits[21];
        output_bits[79] = input_bits[20];
        output_bits[80] = input_bits[19];
        output_bits[81] = input_bits[18];
        output_bits[82] = input_bits[17];
        output_bits[83] = input_bits[16];
        output_bits[84] = input_bits[15];
        output_bits[85] = input_bits[14];
        output_bits[86] = input_bits[13];
        output_bits[87] = input_bits[12];
        output_bits[88] = input_bits[11];
        output_bits[89] = input_bits[10];
        output_bits[90] = input_bits[9];
        output_bits[91] = input_bits[8];
        output_bits[92] = input_bits[7];
        output_bits[93] = input_bits[6];
        output_bits[94] = input_bits[5];
        output_bits[95] = input_bits[4];
        output_bits[96] = input_bits[3];
        output_bits[97] = input_bits[2];
        output_bits[98] = input_bits[1];
        output_bits[99] = input_bits[0];
    end

endmodule
[DONE]