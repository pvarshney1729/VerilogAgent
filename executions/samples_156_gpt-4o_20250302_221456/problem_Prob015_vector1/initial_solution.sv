module TopModule (
    input logic [15:0] in,
    output logic [7:0] out_hi,
    output logic [7:0] out_lo
);

    // Assign the upper 8 bits of 'in' to 'out_hi'
    assign out_hi = in[15:8];

    // Assign the lower 8 bits of 'in' to 'out_lo'
    assign out_lo = in[7:0];

endmodule