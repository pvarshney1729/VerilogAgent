module TopModule (
    input logic a, // 1-bit input, unsigned
    input logic b, // 1-bit input, unsigned
    input logic c, // 1-bit input, unsigned
    input logic d, // 1-bit input, unsigned
    output logic out // 1-bit output, unsigned
);

assign out = (~a & ~b & ~c & ~d) | 
             (~a & ~b & ~c & d) | 
             (~a & ~b & c & ~d) | 
             (~a & b & c & d) | 
             (a & ~b & c & d) | 
             (a & b & ~c & d) | 
             (a & b & c & ~d);

endmodule