module TopModule (
    input logic a,
    input logic b,
    output logic q
);
    assign q = (b | (a & ~b));
endmodule