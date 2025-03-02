module logic_expression (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    assign q = (b & d) | (c & a) | (c & b);

endmodule