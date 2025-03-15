module TopModule(
    input  wire in,
    output wire out
);
    // Connect the input directly to the output to behave like a wire
    assign out = in;
endmodule