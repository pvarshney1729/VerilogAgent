module TopModule(
    input logic [1023:0] in, // 1024-bit input vector
    input logic [7:0] sel,   // 8-bit selection input
    output logic [3:0] out   // 4-bit output
);

    always @(*) begin
        // Calculate the starting bit position based on the selection input
        // and select the appropriate 4-bit slice
        out = in[sel * 4 +: 4];
    end

endmodule