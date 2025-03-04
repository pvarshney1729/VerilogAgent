module TopModule(
    input [1023:0] in,
    input [7:0] sel,
    output logic [3:0] out
);

    always @(*) begin
        out = in[(sel * 4) + 3 -: 4];
    end

endmodule