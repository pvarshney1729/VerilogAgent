module TopModule(
    input logic c,
    input logic d,
    input logic a,
    input logic b,
    output logic [3:0] mux_in
);

    logic mux0, mux1, mux2, mux3;

    assign mux0 = (c & ~d) | (c & d) | (~c & d); // mux_in[0]
    assign mux1 = 1'b0;                          // mux_in[1]
    assign mux2 = c & d;                        // mux_in[2]
    assign mux3 = (~c & ~d) | (c & ~d) | (c & d); // mux_in[3]

    assign mux_in = {mux3, mux2, mux1, mux0};

endmodule