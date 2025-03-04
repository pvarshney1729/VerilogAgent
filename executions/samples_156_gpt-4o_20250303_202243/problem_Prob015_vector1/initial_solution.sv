module TopModule(
    input  logic [15:0] in,
    output logic [7:0]  out_hi,
    output logic [7:0]  out_lo
);

    // Assign the upper byte of 'in' to 'out_hi'
    assign out_hi = in[15:8];

    // Assign the lower byte of 'in' to 'out_lo'
    assign out_lo = in[7:0];

endmodule