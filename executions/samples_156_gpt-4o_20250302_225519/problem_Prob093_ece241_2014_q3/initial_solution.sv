module TopModule(
    input wire c,
    input wire d,
    output wire [3:0] mux_in
);
    assign mux_in[0] = (~c & d) | (c & ~d);
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = c | (~c & d);
    assign mux_in[3] = 1'b1;
endmodule