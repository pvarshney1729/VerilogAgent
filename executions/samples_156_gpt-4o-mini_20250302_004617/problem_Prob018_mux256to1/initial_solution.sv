module TopModule (
    input  logic [255:0] in,   // 256-bit input vector, unsigned
    input  logic [7:0]   sel,  // 8-bit selection input, unsigned
    output logic         out    // 1-bit output
);
    assign out = in[sel]; // Select the appropriate bit from the input vector
endmodule