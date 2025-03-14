module TopModule (
    input logic [15:0] in,    // 16-bit input
    output logic [7:0] out_hi, // 8-bit output for upper byte
    output logic [7:0] out_lo   // 8-bit output for lower byte
);

    assign out_hi = in[15:8]; // Assign upper byte
    assign out_lo = in[7:0];  // Assign lower byte

endmodule