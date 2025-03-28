module TopModule (
    input  logic x3,
    input  logic x2,
    input  logic x1,
    output logic f
);

    // Combinational logic for output f
    assign f = (~x3 & x2) | (x3 & x1);

endmodule