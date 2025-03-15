module TopModule (
    input  logic in,
    output logic out
);

    // Since the module behaves like a wire, we directly assign the input to the output
    assign out = in;

endmodule