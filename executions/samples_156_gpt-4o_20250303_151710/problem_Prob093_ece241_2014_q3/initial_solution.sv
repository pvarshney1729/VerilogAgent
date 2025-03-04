module TopModule (
    input wire c,          // Input signal 'c'
    input wire d,          // Input signal 'd'
    output wire [3:0] mux_in // 4-bit output connecting to the 4-to-1 multiplexer
);

    // Assign mux_in based on the Karnaugh map interpretation
    assign mux_in[0] = (~c & ~d); // ab = 00
    assign mux_in[1] = (c & ~d);  // ab = 01
    assign mux_in[2] = (c & d);   // ab = 11
    assign mux_in[3] = (~c & d);  // ab = 10

endmodule