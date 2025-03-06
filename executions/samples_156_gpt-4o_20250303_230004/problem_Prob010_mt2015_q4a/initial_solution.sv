module TopModule (
    input wire x,  // Single-bit input, assumes unsigned
    input wire y,  // Single-bit input, assumes unsigned
    output wire z  // Single-bit output, assumes unsigned
);

    // Implement the Boolean function z = (x ^ y) & x
    assign z = (x ^ y) & x;

endmodule