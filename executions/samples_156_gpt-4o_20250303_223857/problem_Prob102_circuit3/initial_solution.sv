module TopModule (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);
    // Derived logic function implementation
    assign q = (b & d) | (c & ~a);
endmodule