module TopModule(
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire q
);

    // Combinational logic implementation based on the truth table
    assign q = (~a & ~b & ~c & ~d) |
               (~a & ~b &  c &  d) |
               (~a &  b & ~c &  d) |
               (~a &  b &  c & ~d) |
               ( a & ~b &  c & ~d) |
               ( a & ~b & ~c &  d) |
               ( a &  b & ~c & ~d) |
               ( a &  b &  c &  d);

endmodule