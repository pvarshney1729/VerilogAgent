module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // mux_in[0] corresponds to ab = 00
    // From K-map: mux_in[0] = c'd + cd'
    assign mux_in[0] = (~c & d) | (c & ~d);

    // mux_in[1] corresponds to ab = 01
    // From K-map: mux_in[1] = 0
    assign mux_in[1] = 1'b0;

    // mux_in[2] corresponds to ab = 11
    // From K-map: mux_in[2] = cd
    assign mux_in[2] = c & d;

    // mux_in[3] corresponds to ab = 10
    // From K-map: mux_in[3] = c + d
    assign mux_in[3] = c | d;

endmodule