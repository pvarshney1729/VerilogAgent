module TopModule (
    input logic a,
    input logic b,
    output logic q
);
    assign q = (a & b) | (b & ~a);
endmodule