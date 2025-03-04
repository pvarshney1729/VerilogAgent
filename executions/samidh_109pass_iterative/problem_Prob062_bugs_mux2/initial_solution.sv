module TopModule (
    input        sel,       // Selection signal for the multiplexer
    input  [7:0] a,         // 8-bit input vector 'a'
    input  [7:0] b,         // 8-bit input vector 'b'
    output [7:0] out        // 8-bit output vector 'out'
);

// Implementation:
assign out = sel ? b : a;

endmodule