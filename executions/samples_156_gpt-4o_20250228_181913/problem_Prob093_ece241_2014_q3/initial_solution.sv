module TopModule(
    input logic c,
    input logic d,
    input logic a,
    input logic b,
    output logic [3:0] mux_in
);
    assign mux_in[0] = (~c & d) | (c & d);
    assign mux_in[1] = 0;
    assign mux_in[2] = c & d;
    assign mux_in[3] = (~c & d) | (c & ~d);

endmodule