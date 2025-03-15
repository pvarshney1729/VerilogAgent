module TopModule (
    input  logic a,
    input  logic b,
    output logic q
);

    // Combinational logic: q is 1 only when both a and b are 1
    assign q = a & b;

endmodule