module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    logic and_out;

    // Combinational logic for the AND gate with in2 inverted
    assign and_out = in1 & ~in2;

    // Output assignment
    assign out = and_out;

endmodule