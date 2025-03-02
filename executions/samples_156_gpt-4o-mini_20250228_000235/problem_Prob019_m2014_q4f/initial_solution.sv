module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    // Combinational logic for the AND gate with inverted in2
    assign out = in1 & ~in2;

endmodule