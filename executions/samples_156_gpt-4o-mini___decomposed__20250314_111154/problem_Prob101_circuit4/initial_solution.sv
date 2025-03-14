module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);
    assign q = (a & b & c) | (b & d) | (c & d);
endmodule