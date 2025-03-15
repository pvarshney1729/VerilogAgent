module TopModule (
    input  logic [1023:0] in,  // 1024-bit input vector
    input  logic [7:0]    sel, // 8-bit selection input
    output logic [3:0]    out  // 4-bit output
);

    // Assign the selected 4-bit segment from the input vector to the output
    assign out = in[sel*4 +: 4];

endmodule