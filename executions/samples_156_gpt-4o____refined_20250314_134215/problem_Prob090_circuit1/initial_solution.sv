module TopModule (
    input  logic a,
    input  logic b,
    output logic q
);

    // Combinational logic to determine the output q
    assign q = a & b;

endmodule