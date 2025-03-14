module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Intermediate signals for 2-to-1 multiplexers
    logic mux1_out, mux2_out, mux3_out;

    // Implementing the Karnaugh map using multiplexers
    // mux1_out = (c == 0) ? 0 : 1;  // Simplified to c
    assign mux1_out = c;

    // mux2_out = (c == 0) ? 1 : 0;  // Simplified to ~c
    assign mux2_out = ~c;

    // mux3_out = (c == 0) ? 1 : d;  // Simplified to ~c | d
    assign mux3_out = ~c | d;

    // Assigning values to mux_in based on the Karnaugh map
    assign mux_in[0] = mux1_out;  // ab = 00
    assign mux_in[1] = mux2_out;  // ab = 01
    assign mux_in[2] = mux3_out;  // ab = 11
    assign mux_in[3] = 1'b1;      // ab = 10

endmodule