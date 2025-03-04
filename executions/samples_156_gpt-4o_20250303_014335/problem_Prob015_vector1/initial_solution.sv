module TopModule (
    input  logic [15:0] in,     // 16-bit unsigned input
    output logic [7:0]  out_hi, // Upper 8 bits of the input
    output logic [7:0]  out_lo  // Lower 8 bits of the input
);

    assign out_hi = in[15:8];
    assign out_lo = in[7:0];

endmodule