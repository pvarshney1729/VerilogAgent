module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a, b;
    logic mux2_0_out, mux2_1_out, mux2_2_out;

    // Assigning a and b based on c and d
    assign a = c;
    assign b = d;

    // Implementing the 2-to-1 multiplexers
    // mux2_0 for ab = 00
    assign mux2_0_out = (b == 1'b0) ? 1'b0 : 1'b1; // 0 for 00, 1 for 01

    // mux2_1 for ab = 01
    assign mux2_1_out = (b == 1'b0) ? 1'b1 : 1'b0; // 1 for 10, 0 for 11

    // mux2_2 for ab = 10
    assign mux2_2_out = (b == 1'b0) ? 1'b1 : 1'b1; // 1 for 10, 1 for 11

    // Final 4-to-1 multiplexer
    assign mux_in[0] = mux2_0_out; // ab = 00
    assign mux_in[1] = mux2_1_out; // ab = 01
    assign mux_in[2] = (c == 1'b1) ? mux2_2_out : 1'b0; // ab = 10
    assign mux_in[3] = (c == 1'b1) ? 1'b1 : 1'b0; // ab = 11

endmodule