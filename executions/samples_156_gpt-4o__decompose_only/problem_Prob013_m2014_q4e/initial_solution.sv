module TopModule (
    input  logic in1,
    input  logic in2,
    output logic out
);

    // Implementing the NOR gate logic
    assign out = ~(in1 | in2);

endmodule