module TopModule(
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    assign out = (sel <= 8'd255) ? in[(sel * 4) + 3 -: 4] : 4'bx;
endmodule