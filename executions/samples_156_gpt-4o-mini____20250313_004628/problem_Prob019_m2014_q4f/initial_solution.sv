module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    logic not_in2;

    // Invert in2
    assign not_in2 = ~in2;

    // AND gate with inverted in2
    assign out = in1 & not_in2;

endmodule