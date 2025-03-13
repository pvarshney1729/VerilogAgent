module TopModule (
    input  logic [7:0] a,         // 8-bit two's complement input
    input  logic [7:0] b,         // 8-bit two's complement input
    output logic [7:0] s,         // 8-bit two's complement sum output
    output logic overflow          // 1-bit overflow flag output
);

assign s = a + b; // Sum of the two inputs

// Overflow detection for two's complement addition
assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule