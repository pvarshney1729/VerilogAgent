module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);

    assign q = (c & ~a) | b;

endmodule