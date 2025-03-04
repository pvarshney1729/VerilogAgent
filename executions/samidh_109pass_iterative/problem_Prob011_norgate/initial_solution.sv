module TopModule (
    input wire a,  // 1-bit input
    input wire b,  // 1-bit input
    output wire out // 1-bit output
);

// NOR gate implementation
assign out = ~(a | b);

endmodule