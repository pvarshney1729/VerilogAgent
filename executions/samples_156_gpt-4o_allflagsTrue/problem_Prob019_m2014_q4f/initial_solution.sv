module TopModule(
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Perform NOT operation on in2 and then AND with in1
    assign out = in1 & ~in2;

endmodule