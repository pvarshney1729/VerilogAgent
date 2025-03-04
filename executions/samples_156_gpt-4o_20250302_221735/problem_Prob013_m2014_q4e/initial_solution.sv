module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    // Implementing the NOR gate using an assign statement
    assign out = ~(in1 | in2);

endmodule