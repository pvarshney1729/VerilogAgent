module TopModule (
    input  logic [1023:0] in,  // 1024-bit wide input vector, unsigned
    input  logic [7:0]    sel, // 8-bit wide selector, unsigned
    output logic [3:0]    out  // 4-bit wide output, unsigned
);

assign out = in[(sel * 4) +: 4];

endmodule