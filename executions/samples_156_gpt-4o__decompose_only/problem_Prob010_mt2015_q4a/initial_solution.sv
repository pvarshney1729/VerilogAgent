module TopModule(
    input  logic x,
    input  logic y,
    output logic z
);

    // Implement the boolean function z = (x ^ y) & x
    assign z = (x ^ y) & x;

endmodule