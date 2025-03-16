module TopModule (
    input logic in,
    output logic out
);

    // The module behaves like a wire, directly connecting input to output
    assign out = in;

endmodule