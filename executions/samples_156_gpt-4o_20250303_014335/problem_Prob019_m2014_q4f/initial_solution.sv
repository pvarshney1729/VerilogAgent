module TopModule(
    input logic in1,
    input logic in2,
    output logic out
);
    assign out = in1 & ~in2; // Implements the AND gate with in2 inverted
endmodule