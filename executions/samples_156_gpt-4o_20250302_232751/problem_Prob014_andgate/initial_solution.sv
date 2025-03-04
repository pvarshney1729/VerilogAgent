module TopModule (
    input wire a,   // Single-bit input 'a'
    input wire b,   // Single-bit input 'b'
    output wire out // Single-bit output 'out'
);

// Combinational Logic
assign out = a & b;

endmodule