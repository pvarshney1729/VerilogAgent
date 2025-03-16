module TopModule(
    input logic in1,
    input logic in2,
    output logic out
);

    // Perform the AND operation with in2 inverted
    assign out = in1 & ~in2;

endmodule