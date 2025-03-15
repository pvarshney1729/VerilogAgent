module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    logic and_out;

    // Combinational logic for AND gate with inverted in2
    assign and_out = in1 & ~in2;

    // Output assignment
    assign out = and_out;

endmodule