module TopModule (
    input  logic [255:0] in,  // 256-bit input vector
    input  logic [7:0]   sel, // 8-bit selection input
    output logic         out  // 1-bit output
);

    // Assign the selected bit from the input vector to the output
    assign out = in[sel];

endmodule