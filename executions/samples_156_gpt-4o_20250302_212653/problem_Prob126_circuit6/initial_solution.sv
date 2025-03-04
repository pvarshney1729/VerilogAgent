module TopModule (
    input  wire [2:0] a, // 3-bit unsigned input
    output wire [15:0] q // 16-bit unsigned output
);

    assign q = (a == 3'b000) ? 16'h1232 :
               (a == 3'b001) ? 16'haee0 :
               (a == 3'b010) ? 16'h27d4 :
               (a == 3'b011) ? 16'h5a0e :
               (a == 3'b100) ? 16'h2066 :
               (a == 3'b101) ? 16'h64ce :
               (a == 3'b110) ? 16'hc526 :
               (a == 3'b111) ? 16'h2f19 : 16'h0000;

endmodule