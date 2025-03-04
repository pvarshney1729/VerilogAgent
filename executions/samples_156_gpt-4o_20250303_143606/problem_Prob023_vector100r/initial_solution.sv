module TopModule (
    input  wire [99:0] in_signal,  // Input: 100-bit wide signal
    output wire [99:0] out_signal  // Output: 100-bit wide reversed signal
);

    // Reverse the bits of in_signal and assign to out_signal
    assign out_signal = {in_signal[0], in_signal[1], in_signal[2], in_signal[3], in_signal[4], 
                         in_signal[5], in_signal[6], in_signal[7], in_signal[8], in_signal[9], 
                         in_signal[10], in_signal[11], in_signal[12], in_signal[13], in_signal[14], 
                         in_signal[15], in_signal[16], in_signal[17], in_signal[18], in_signal[19], 
                         in_signal[20], in_signal[21], in_signal[22], in_signal[23], in_signal[24], 
                         in_signal[25], in_signal[26], in_signal[27], in_signal[28], in_signal[29], 
                         in_signal[30], in_signal[31], in_signal[32], in_signal[33], in_signal[34], 
                         in_signal[35], in_signal[36], in_signal[37], in_signal[38], in_signal[39], 
                         in_signal[40], in_signal[41], in_signal[42], in_signal[43], in_signal[44], 
                         in_signal[45], in_signal[46], in_signal[47], in_signal[48], in_signal[49], 
                         in_signal[50], in_signal[51], in_signal[52], in_signal[53], in_signal[54], 
                         in_signal[55], in_signal[56], in_signal[57], in_signal[58], in_signal[59], 
                         in_signal[60], in_signal[61], in_signal[62], in_signal[63], in_signal[64], 
                         in_signal[65], in_signal[66], in_signal[67], in_signal[68], in_signal[69], 
                         in_signal[70], in_signal[71], in_signal[72], in_signal[73], in_signal[74], 
                         in_signal[75], in_signal[76], in_signal[77], in_signal[78], in_signal[79], 
                         in_signal[80], in_signal[81], in_signal[82], in_signal[83], in_signal[84], 
                         in_signal[85], in_signal[86], in_signal[87], in_signal[88], in_signal[89], 
                         in_signal[90], in_signal[91], in_signal[92], in_signal[93], in_signal[94], 
                         in_signal[95], in_signal[96], in_signal[97], in_signal[98], in_signal[99]};

endmodule