module TopModule (
    input logic [7:0] sel,
    input logic [255:0] data,
    output logic [3:0] out
);

    always @(*) begin
        case (sel)
            8'b00000000: out = data[3:0];
            8'b00000001: out = data[7:4];
            8'b00000010: out = data[11:8];
            8'b00000011: out = data[15:12];
            8'b00000100: out = data[19:16];
            8'b00000101: out = data[23:20];
            8'b00000110: out = data[27:24];
            8'b00000111: out = data[31:28];
            8'b00001000: out = data[35:32];
            8'b00001001: out = data[39:36];
            8'b00001010: out = data[43:40];
            8'b00001011: out = data[47:44];
            8'b00001100: out = data[51:48];
            8'b00001101: out = data[55:52];
            8'b00001110: out = data[59:56];
            8'b00001111: out = data[63:60];
            8'b00010000: out = data[67:64];
            8'b00010001: out = data[71:68];
            8'b00010010: out = data[75:72];
            8'b00010011: out = data[79:76];
            8'b00010100: out = data[83:80];
            8'b00010101: out = data[87:84];
            8'b00010110: out = data[91:88];
            8'b00010111: out = data[95:92];
            8'b00011000: out = data[99:96];
            8'b00011001: out = data[103:100];
            8'b00011010: out = data[107:104];
            8'b00011011: out = data[111:108];
            8'b00011100: out = data[115:112];
            8'b00011101: out = data[119:116];
            8'b00011110: out = data[123:120];
            8'b00011111: out = data[127:124];
            8'b00100000: out = data[131:128];
            8'b00100001: out = data[135:132];
            8'b00100010: out = data[139:136];
            8'b00100011: out = data[143:140];
            8'b00100100: out = data[147:144];
            8'b00100101: out = data[151:148];
            8'b00100110: out = data[155:152];
            8'b00100111: out = data[159:156];
            8'b00101000: out = data[163:160];
            8'b00101001: out = data[167:164];
            8'b00101010: out = data[171:168];
            8'b00101011: out = data[175:172];
            8'b00101100: out = data[179:176];
            8'b00101101: out = data[183:180];
            8'b00101110: out = data[187:184];
            8'b00101111: out = data[191:188];
            8'b00110000: out = data[195:192];
            8'b00110001: out = data[199:196];
            8'b00110010: out = data[203:200];
            8'b00110011: out = data[207:204];
            8'b00110100: out = data[211:208];
            8'b00110101: out = data[215:212];
            8'b00110110: out = data[219:216];
            8'b00110111: out = data[223:220];
            8'b00111000: out = data[227:224];
            8'b00111001: out = data[231:228];
            8'b00111010: out = data[235:232];
            8'b00111011: out = data[239:236];
            8'b00111100: out = data[243:240];
            8'b00111101: out = data[247:244];
            8'b00111110: out = data[251:248];
            8'b00111111: out = data[255:252];
            default: out = 4'b0000;
        endcase
    end

endmodule