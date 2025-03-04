module TopModule (
    input logic [255:0] in,    // 256-bit input vector, in[0] is LSB
    input logic [7:0] sel,     // 8-bit unsigned selector
    output logic out           // 1-bit output
);

assign out = (sel < 8'd256) ? in[sel] : 1'b0;

endmodule