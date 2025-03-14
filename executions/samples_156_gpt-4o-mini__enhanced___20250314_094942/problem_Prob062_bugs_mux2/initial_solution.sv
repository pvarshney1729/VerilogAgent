module TopModule (
    input         sel,         // Selection signal (1 bit)
    input  [7:0]  a,          // First input (8 bits)
    input  [7:0]  b,          // Second input (8 bits)
    output [7:0]  out         // Output (8 bits)
);

    // Behavioral Description
    // The output 'out' is determined by the selection signal 'sel':
    // If sel is 0, out = a; if sel is 1, out = b.
    // This module operates as a combinational 2-to-1 multiplexer.
    assign out = (sel == 1'b0) ? a : b;

endmodule