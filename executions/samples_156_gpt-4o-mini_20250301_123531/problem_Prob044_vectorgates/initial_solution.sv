module TopModule (
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [5:0] out_not
);

    assign out_or_bitwise = a | b;
    assign out_or_logical = |{a, b}; // Logical OR of all bits in a and b
    assign out_not[5:3] = ~b; // Bitwise NOT of b
    assign out_not[2:0] = ~a; // Bitwise NOT of a

endmodule