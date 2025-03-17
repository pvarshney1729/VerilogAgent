module TopModule(
    input  logic a,
    input  logic b,
    output logic q
);

    // Implementing the combinational logic using an AND gate
    assign q = a & b;

endmodule