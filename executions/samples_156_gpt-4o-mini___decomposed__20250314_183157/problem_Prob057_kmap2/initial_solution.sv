module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic out
);
    assign out = (a & ~b & ~c & ~d) | (a & ~b & d) | (a & b & ~d) | (~a & b & c) | (~a & b & d);
endmodule