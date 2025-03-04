module TopModule (
    input wire c,        // 1-bit input, unsigned
    input wire d,        // 1-bit input, unsigned
    input wire a,        // 1-bit input, unsigned, selector for 4-to-1 mux
    input wire b,        // 1-bit input, unsigned, selector for 4-to-1 mux
    output wire [3:0] mux_in  // 4-bit output, unsigned
);

    // Combinational logic for mux_in based on Karnaugh map
    assign mux_in[0] = (!c & !d) | (c & d) | (c & !d);
    assign mux_in[1] = (!c & d);
    assign mux_in[2] = (c & d);
    assign mux_in[3] = (!c & !d) | (c & d);

    // 4-to-1 multiplexer logic
    wire mux_out;
    assign mux_out = (a == 1'b0 && b == 1'b0) ? mux_in[0] :
                     (a == 1'b0 && b == 1'b1) ? mux_in[1] :
                     (a == 1'b1 && b == 1'b0) ? mux_in[3] :
                     mux_in[2];

endmodule