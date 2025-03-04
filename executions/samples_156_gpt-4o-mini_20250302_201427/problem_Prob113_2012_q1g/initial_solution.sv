module TopModule(
    input logic [3:0] x,
    output logic f
);
    assign f = (x == 4'b0000) ? 1'b1 :
               (x == 4'b0010) ? 1'b1 :
               (x == 4'b1110) ? 1'b0 :
               (x == 4'b1100) ? 1'b1 :
               (x == 4'b1101) ? 1'b1 :
               (x == 4'b1111) ? 1'b1 :
               (x == 4'b1011) ? 1'b0 :
               (x == 4'b1010) ? 1'b1 : 1'b0;
endmodule