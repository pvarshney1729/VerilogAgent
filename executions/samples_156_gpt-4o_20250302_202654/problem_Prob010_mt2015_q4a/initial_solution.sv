module TopModule (
    input wire x,  // Unsigned 1-bit input
    input wire y,  // Unsigned 1-bit input
    output wire z  // Unsigned 1-bit output
);

    assign z = (x ^ y) & x;

endmodule