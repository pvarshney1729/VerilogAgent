module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

assign q = (~a & ~b & ~d) | (~a & c & d) | (a & b & ~c) | (a & ~b & c & ~d) | (a & b & d);

endmodule