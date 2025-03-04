module TopModule(
    input [1023:0] in,  // 1024-bit input vector
    input [7:0] sel,    // 8-bit selector input
    output logic [3:0] out  // 4-bit output
);

    always @(*) begin
        out = in[(sel * 4) + 3 : sel * 4];
    end

endmodule