module TopModule (
    input  wire [255:0] in,   // 256-bit wide input vector, unsigned
    input  wire [7:0]   sel,  // 8-bit wide select signal, unsigned
    output wire         out   // 1-bit wide output
);

    assign out = (sel < 8'd256) ? in[sel] : 1'b0;

endmodule