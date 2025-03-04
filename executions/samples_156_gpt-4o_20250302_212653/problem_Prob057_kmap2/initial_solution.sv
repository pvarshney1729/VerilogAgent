module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input
    output logic out // 1-bit output
);

assign out = (~a & ~c & ~d) | (~b & ~d) | (a & b & c) | (~a & c & d) | (a & ~b & ~d);

endmodule