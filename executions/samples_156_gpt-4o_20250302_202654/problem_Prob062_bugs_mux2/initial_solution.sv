module Mux8Bit2to1 (
    input  logic       sel,    // 1-bit selector signal
    input  logic [7:0] a,      // 8-bit input vector 'a'
    input  logic [7:0] b,      // 8-bit input vector 'b'
    output logic [7:0] out     // 8-bit output vector 'out'
);

// Implementation using bit-wise operations to select between inputs
assign out = (~{8{sel}} & a) | ({8{sel}} & b);

endmodule