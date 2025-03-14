module TopModule(
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    assign q = (c & ~d) | (b & ~a) | (c & d);

endmodule