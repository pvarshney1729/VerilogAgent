module TopModule (
    input wire in,  // Single bit input; treated as a wire, unsigned by default
    output wire out // Single bit output; treated as a wire, unsigned by default
);

    // Direct wire connection from in to out
    assign out = in;

endmodule