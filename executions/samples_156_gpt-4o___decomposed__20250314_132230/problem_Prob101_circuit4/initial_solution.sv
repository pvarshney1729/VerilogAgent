module TopModule(
    input  a,
    input  b,
    input  c,
    input  d,
    output logic q
);

    assign q = (b & ~a) | c;

endmodule