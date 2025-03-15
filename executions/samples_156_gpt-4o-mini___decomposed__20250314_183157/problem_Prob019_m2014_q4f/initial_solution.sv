module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    logic not_in2;
    logic and_out;

    assign not_in2 = ~in2;       // Bubble version of in2
    assign and_out = in1 & not_in2; // AND gate
    assign out = and_out;        // Connect output to out

endmodule