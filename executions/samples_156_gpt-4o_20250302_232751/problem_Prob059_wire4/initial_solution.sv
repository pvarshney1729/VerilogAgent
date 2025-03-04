module TopModule (
    input  wire a, // Single-bit input
    input  wire b, // Single-bit input
    input  wire c, // Single-bit input
    output wire w, // Single-bit output
    output wire x, // Single-bit output
    output wire y, // Single-bit output
    output wire z  // Single-bit output
);

    // Direct connections
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;

endmodule