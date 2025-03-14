module TopModule (
    input logic a,      // 1-bit input signal 'a'
    input logic b,      // 1-bit input signal 'b'
    input logic c,      // 1-bit input signal 'c'
    output logic out    // 1-bit output signal 'out'
);

assign out = (b & ~c) | (c & ~a) | (a & b) | (a & c);

endmodule