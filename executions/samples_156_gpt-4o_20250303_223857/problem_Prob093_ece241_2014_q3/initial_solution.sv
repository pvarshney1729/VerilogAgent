module TopModule(
    input wire c,      // 1-bit input
    input wire d,      // 1-bit input
    input wire [1:0] ab, // 2-bit input, selector for 4-to-1 mux
    output wire [3:0] mux_in // 4-bit output
);

    assign mux_in[0] = (c & ~d) | (c & d) | (~c & d);
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = c & d;
    assign mux_in[3] = (~c & ~d) | (c & ~d) | (c & d);

endmodule