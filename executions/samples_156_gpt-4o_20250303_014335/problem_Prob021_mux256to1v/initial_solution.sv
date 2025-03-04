module TopModule (
    input logic [1023:0] in,  // 1024-bit input vector, unsigned
    input logic [7:0] sel,    // 8-bit selection input, unsigned
    output logic [3:0] out    // 4-bit output vector, unsigned
);

    always_comb begin
        out = in[(sel * 4) + 3 -: 4];
    end

endmodule