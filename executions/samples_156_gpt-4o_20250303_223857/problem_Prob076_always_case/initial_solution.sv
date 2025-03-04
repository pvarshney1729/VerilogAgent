module TopModule(
    input  [2:0] sel,
    input  [3:0] data0, data1, data2, data3, data4, data5,
    output [3:0] out
);

    assign out = (sel == 3'b000) ? data0 :
                 (sel == 3'b001) ? data1 :
                 (sel == 3'b010) ? data2 :
                 (sel == 3'b011) ? data3 :
                 (sel == 3'b100) ? data4 :
                 (sel == 3'b101) ? data5 :
                 4'b0000;

endmodule