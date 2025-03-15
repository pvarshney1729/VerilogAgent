module TopModule (
    input  logic [2:0] a,
    input  logic [2:0] b,
    output logic [2:0] out_or_bitwise,
    output logic out_or_logical,
    output logic [5:0] out_not
);

    // Compute bitwise OR of a and b
    assign out_or_bitwise = a | b;

    // Compute logical OR of a and b
    assign out_or_logical = (a[0] | b[0]) | (a[1] | b[1]) | (a[2] | b[2]);

    // Compute NOT of a and b
    assign out_not = {~b, ~a};  // Concatenate the NOT of b and NOT of a

endmodule