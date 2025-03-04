module TopModule (
    input wire x3,  // 1-bit input signal
    input wire x2,  // 1-bit input signal
    input wire x1,  // 1-bit input signal
    output wire f   // 1-bit output signal
);

// Implementation
assign f = (x2 & ~x3) | (x1 & x3) | (x1 & x2 & ~x3);

endmodule