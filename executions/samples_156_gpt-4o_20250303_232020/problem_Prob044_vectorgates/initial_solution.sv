module TopModule (
    input  logic [2:0] a,
    input  logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic       out_or_logical,
    output logic [5:0] out_not
);

    // Bitwise OR operation
    assign out_or_bitwise = a | b;

    // Logical OR operation
    assign out_or_logical = |a | |b;

    // Bitwise NOT operation
    assign out_not[5:3] = ~b;
    assign out_not[2:0] = ~a;

endmodule