module TopModule (
    input logic a, // 1-bit input
    input logic b, // 1-bit input
    input logic c, // 1-bit input
    input logic d, // 1-bit input
    output logic q // 1-bit output
);

    // Combinational logic derived from the truth table
    assign q = (~a & ~b & ~c & ~d) |
               (~a & ~b &  c &  d) |
               (~a &  b & ~c &  d) |
               (~a &  b &  c & ~d) |
               ( a & ~b & ~c &  d) |
               ( a & ~b &  c & ~d) |
               ( a &  b & ~c & ~d) |
               ( a &  b &  c &  d);

endmodule