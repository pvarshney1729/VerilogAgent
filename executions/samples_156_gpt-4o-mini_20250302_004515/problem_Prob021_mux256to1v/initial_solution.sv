module TopModule (
    input logic [1023:0] in,    // 1024-bit input vector, unsigned
    input logic [7:0] sel,      // 8-bit selection signal, unsigned
    output logic [3:0] out       // 4-bit output vector, unsigned
);

    always @(*) begin
        out = in[(sel * 4) +: 4]; // Select 4 bits based on sel
    end

endmodule