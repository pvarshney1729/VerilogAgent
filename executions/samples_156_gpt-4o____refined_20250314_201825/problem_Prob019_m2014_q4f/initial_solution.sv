module TopModule (
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Implementing the AND gate with in2 input having a bubble (NOT gate)
    assign out = in1 & ~in2;

endmodule