module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);
    logic a = c;
    logic b = d;

    // 2-to-1 multiplexers
    logic mux0_out, mux1_out, mux2_out, mux3_out;

    assign mux0_out = 1'b0; // For ab = 00
    assign mux1_out = a;    // For ab = 01
    assign mux2_out = (a & b); // For ab = 11
    assign mux3_out = (a | b); // For ab = 10

    // Connect 2-to-1 mux outputs to 4-to-1 mux inputs
    assign mux_in[0] = mux0_out; // ab = 00
    assign mux_in[1] = mux1_out; // ab = 01
    assign mux_in[2] = mux2_out; // ab = 11
    assign mux_in[3] = mux3_out; // ab = 10

endmodule