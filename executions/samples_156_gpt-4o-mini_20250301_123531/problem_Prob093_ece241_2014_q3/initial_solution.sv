module TopModule (
    input logic c, // Input 'c', 1-bit, used for K-map row selection
    input logic d, // Input 'd', 1-bit, used for K-map row selection
    output logic [3:0] mux_in // 4-bit output connecting to a 4-to-1 multiplexer
);

    assign mux_in[0] = (c ~& d) | (c & ~d) | (c & d); // K-map entry for ab = 00
    assign mux_in[1] = 1'b0;                          // K-map entry for ab = 01
    assign mux_in[2] = c & d;                         // K-map entry for ab = 11
    assign mux_in[3] = (c ~& d) | (c & d);           // K-map entry for ab = 10

endmodule