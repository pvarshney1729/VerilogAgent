module TopModule (
    input  logic in,
    output logic out
);

    // Implementing a NOT gate using an assign statement
    assign out = ~in;

endmodule