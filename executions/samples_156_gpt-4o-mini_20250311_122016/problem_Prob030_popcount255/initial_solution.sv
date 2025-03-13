[BEGIN]
```verilog
module TopModule (
    input  logic [254:0] in,
    output logic [7:0]   out
);

    logic [7:0] count[7:0]; // Array to hold counts of 32-bit segments

    // Count number of 1s in 32-bit segments
    always @(*) begin
        count[0] = in[31:0][0] + in[31:0][1] + in[31:0][2] + in[31:0][3] + 
                   in[31:0][4] + in[31:0][5] + in[31:0][6] + in[31:0][7] + 
                   in[31:0][8] + in[31:0][9] + in[31:0][10] + in[31:0][11] + 
                   in[31:0][12] + in[31:0][13] + in[31:0][14] + in[31:0][15] + 
                   in[31:0][16] + in[31:0][17] + in[31:0][18] + in[31:0][19] + 
                   in[31:0][20] + in[31:0][21] + in[31:0][22] + in[31:0][23] + 
                   in[31:0][24] + in[31:0][25] + in[31:0][26] + in[31:0][27] + 
                   in[31:0][28] + in[31:0][29] + in[31:0][30] + in[31:0][31];

        count[1] = in[63:32][0] + in[63:32][1] + in[63:32][2] + in[63:32][3] + 
                   in[63:32][4] + in[63:32][5] + in[63:32][6] + in[63:32][7] + 
                   in[63:32][8] + in[63:32][9] + in[63:32][10] + in[63:32][11] + 
                   in[63:32][12] + in[63:32][13] + in[63:32][14] + in[63:32][15] + 
                   in[63:32][16] + in[63:32][17] + in[63:32][18] + in[63:32][19] + 
                   in[63:32][20] + in[63:32][21] + in[63:32][22] + in[63:32][23] + 
                   in[63:32][24] + in[63:32][25] + in[63:32][26] + in[63:32][27] + 
                   in[63:32][28] + in[63:32][29] + in[63:32][30] + in[63:32][31];

        count[2] = in[95:64][0] + in[95:64][1] + in[95:64][2] + in[95:64][3] + 
                   in[95:64][4] + in[95:64][5] + in[95:64][6] + in[95:64][7] + 
                   in[95:64][8] + in[95:64][9] + in[95:64][10] + in[95:64][11] + 
                   in[95:64][12] + in[95:64][13] + in[95:64][14] + in[95:64][15] + 
                   in[95:64][16] + in[95:64][17] + in[95:64][18] + in[95:64][19] + 
                   in[95:64][20] + in[95:64][21] + in[95:64][22] + in[95:64][23] + 
                   in[95:64][24] + in[95:64][25] + in[95:64][26] + in[95:64][27] + 
                   in[95:64][28] + in[95:64][29] + in[95:64][30] + in[95:64][31];

        count[3] = in[127:96][0] + in[127:96][1] + in[127:96][2] + in[127:96][3] + 
                   in[127:96][4] + in[127:96][5] + in[127:96][6] + in[127:96][7] + 
                   in[127:96][8] + in[127:96][9] + in[127:96][10] + in[127:96][11] + 
                   in[127:96][12] + in[127:96][13] + in[127:96][14] + in[127:96][15] + 
                   in[127:96][16] + in[127:96][17] + in[127:96][18] + in[127:96][19] + 
                   in[127:96][20] + in[127:96][21] + in[127:96][22] + in[127:96][23] + 
                   in[127:96][24] + in[127:96][25] + in[127:96][26] + in[127:96][27] + 
                   in[127:96][28] + in[127:96][29] + in[127:96][30] + in[127:96][31];

        count[4] = in[159:128][0] + in[159:128][1] + in[159:128][2] + in[159:128][3] + 
                   in[159:128][4] + in[159:128][5] + in[159:128][6] + in[159:128][7] + 
                   in[159:128][8] + in[159:128][9] + in[159:128][10] + in[159:128][11] + 
                   in[159:128][12] + in[159:128][13] + in[159:128][14] + in[159:128][15] + 
                   in[159:128][16] + in[159:128][17] + in[159:128][18] + in[159:128][19] + 
                   in[159:128][20] + in[159:128][21] + in[159:128][22] + in[159:128][23] + 
                   in[159:128][24] + in[159:128][25] + in[159:128][26] + in[159:128][27] + 
                   in[159:128][28] + in[159:128][29] + in[159:128][30] + in[159:128][31];

        count[5] = in[191:160][0] + in[191:160][1] + in[191:160][2] + in[191:160][3] + 
                   in[191:160][4] + in[191:160][5] + in[191:160][6] + in[191:160][7] + 
                   in[191:160][8] + in[191:160][9] + in[191:160][10] + in[191:160][11] + 
                   in[191:160][12] + in[191:160][13] + in[191:160][14] + in[191:160][15] + 
                   in[191:160][16] + in[191:160][17] + in[191:160][18] + in[191:160][19] + 
                   in[191:160][20] + in[191:160][21] + in[191:160][22] + in[191:160][23] + 
                   in[191:160][24] + in[191:160][25] + in[191:160][26] + in[191:160][27] + 
                   in[191:160][28] + in[191:160][29] + in[191:160][30] + in[191:160][31];

        count[6] = in[223:192][0] + in[223:192][1] + in[223:192][2] + in[223:192][3] + 
                   in[223:192][4] + in[223:192][5] + in[223:192][6] + in[223:192][7] + 
                   in[223:192][8] + in[223:192][9] + in[223:192][10] + in[223:192][11] + 
                   in[223:192][12]