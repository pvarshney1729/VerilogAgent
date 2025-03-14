[BEGIN]
module TopModule (
    input logic [1023:0] in,  // 1024-bit input vector
    input logic [7:0] sel,     // 8-bit selection input
    output logic [3:0] out     // 4-bit output
);

always @(*) begin
    case (sel)
        8'd0: out = in[3:0];
        8'd1: out = in[7:4];
        8'd2: out = in[11:8];
        8'd3: out = in[15:12];
        8'd4: out = in[19:16];
        8'd5: out = in[23:20];
        8'd6: out = in[27:24];
        8'd7: out = in[31:28];
        8'd8: out = in[35:32];
        8'd9: out = in[39:36];
        8'd10: out = in[43:40];
        8'd11: out = in[47:44];
        8'd12: out = in[51:48];
        8'd13: out = in[55:52];
        8'd14: out = in[59:56];
        8'd15: out = in[63:60];
        8'd16: out = in[67:64];
        8'd17: out = in[71:68];
        8'd18: out = in[75:72];
        8'd19: out = in[79:76];
        8'd20: out = in[83:80];
        8'd21: out = in[87:84];
        8'd22: out = in[91:88];
        8'd23: out = in[95:92];
        8'd24: out = in[99:96];
        8'd25: out = in[103:100];
        8'd26: out = in[107:104];
        8'd27: out = in[111:108];
        8'd28: out = in[115:112];
        8'd29: out = in[119:116];
        8'd30: out = in[123:120];
        8'd31: out = in[127:124];
        8'd32: out = in[131:128];
        8'd33: out = in[135:132];
        8'd34: out = in[139:136];
        8'd35: out = in[143:140];
        8'd36: out = in[147:144];
        8'd37: out = in[151:148];
        8'd38: out = in[155:152];
        8'd39: out = in[159:156];
        8'd40: out = in[163:160];
        8'd41: out = in[167:164];
        8'd42: out = in[171:168];
        8'd43: out = in[175:172];
        8'd44: out = in[179:176];
        8'd45: out = in[183:180];
        8'd46: out = in[187:184];
        8'd47: out = in[191:188];
        8'd48: out = in[195:192];
        8'd49: out = in[199:196];
        8'd50: out = in[203:200];
        8'd51: out = in[207:204];
        8'd52: out = in[211:208];
        8'd53: out = in[215:212];
        8'd54: out = in[219:216];
        8'd55: out = in[223:220];
        8'd56: out = in[227:224];
        8'd57: out = in[231:228];
        8'd58: out = in[235:232];
        8'd59: out = in[239:236];
        8'd60: out = in[243:240];
        8'd61: out = in[247:244];
        8'd62: out = in[251:248];
        8'd63: out = in[255:252];
        8'd64: out = in[259:256];
        8'd65: out = in[263:260];
        8'd66: out = in[267:264];
        8'd67: out = in[271:268];
        8'd68: out = in[275:272];
        8'd69: out = in[279:276];
        8'd70: out = in[283:280];
        8'd71: out = in[287:284];
        8'd72: out = in[291:288];
        8'd73: out = in[295:292];
        8'd74: out = in[299:296];
        8'd75: out = in[303:300];
        8'd76: out = in[307:304];
        8'd77: out = in[311:308];
        8'd78: out = in[315:312];
        8'd79: out = in[319:316];
        8'd80: out = in[323:320];
        8'd81: out = in[327:324];
        8'd82: out = in[331:328];
        8'd83: out = in[335:332];
        8'd84: out = in[339:336];
        8'd85: out = in[343:340];
        8'd86: out = in[347:344];
        8'd87: out = in[351:348];
        8'd88: out = in[355:352];
        8'd89: out = in[359:356];
        8'd90: out = in[363:360];
        8'd91: out = in[367:364];
        8'd92: out = in[371:368];
        8'd93: out = in[375:372];
        8'd94: out = in[379:376];
        8'd95: out = in[383:380];
        8'd96: out = in[387:384];
        8'd97: out = in[391:388];
        8'd98: out = in[395:392];
        8'd99: out = in[399:396];
        8'd100: out = in[403:400];
        8'd101: out = in[407:404];
        8'd102: out = in[411:408];
        8'd103: out = in[415:412];
        8'd104: out = in[419:416];
        8'd105: out = in[423:420];
        8'd106: out = in[427:424];
        8'd107: out = in[431:428];
        8'd108: out = in[435:432];
        8'd109: out = in[439:436];
        8'd110: out = in[443:440];
        8'd111: out = in[447:444];
        8'd112: out = in[451:448];
        8'd113: out = in[455:452];
        8'd114: out = in[459:456];
        8'd115: out = in[463:460];
        8'd116: out = in[467:464];
        8'd117: out = in[471:468];
        8'd118: out = in[475:472];
        8'd119: out = in[479:476];
        8'd120: out = in[483:480];
        8'd121: out = in[487:484];
        8'd122: out = in[491:488];
        8'd123: out = in[495:492];
        8'd124: out = in[499:496];
        8'd125: out = in[503:500];
        8'd126: out = in[507:504];
        8'd127: out = in[511:508];
        8'd128: out = in[515:512];
        8'd129: out = in[519:516];
        8'd130: out = in[523:520];
        8'd131: out = in[527:524];
        8'd132: out = in[531:528];
        8'd133: out = in[535:532];
        8'd134: out = in[539:536];
        8'd135: out = in[543:540];
        8'd136: out = in[547:544];
        8'd137: out = in[551:548];
        8'd138: out = in[555:552];
        8'd139: out = in[559:556];
        8'd140: out = in[563:

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly