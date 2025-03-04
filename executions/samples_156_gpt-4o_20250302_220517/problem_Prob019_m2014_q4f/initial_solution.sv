module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    // Intermediate signal for the inverted input
    logic in2_not;

    // Invert in2
    assign in2_not = ~in2;

    // AND gate
    assign out = in1 & in2_not;

endmodule