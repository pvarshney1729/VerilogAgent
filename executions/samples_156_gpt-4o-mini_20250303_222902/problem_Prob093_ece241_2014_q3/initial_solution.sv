module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);
    // Implement mux_in based on the provided Karnaugh map
    assign mux_in[0] = ~c & ~d; // ab = 00
    assign mux_in[1] = c & ~d;  // ab = 01
    assign mux_in[2] = c & d;    // ab = 11
    assign mux_in[3] = ~c & d;   // ab = 10
endmodule