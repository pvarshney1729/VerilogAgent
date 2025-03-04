module TopModule (
    input wire [1023:0] in,  // 1024-bit input vector
    input wire [7:0] sel,    // 8-bit selection input
    output wire [3:0] out    // 4-bit output
);

    // Combinational logic to select the appropriate 4-bit group
    assign out = in[sel * 4 +: 4];

endmodule