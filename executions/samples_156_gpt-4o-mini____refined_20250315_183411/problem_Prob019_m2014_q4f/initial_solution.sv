module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    logic and_out;

    // Implementing the AND gate with a bubble on in2 (inverted in2)
    assign and_out = in1 & ~in2;

    // Assigning the output
    assign out = and_out;

endmodule