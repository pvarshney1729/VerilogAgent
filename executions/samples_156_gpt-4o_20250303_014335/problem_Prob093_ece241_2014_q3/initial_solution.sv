module TopModule(
    input wire c,
    input wire d,
    output wire [3:0] mux_in
);

    // Assign mux_in[0] based on the Karnaugh map
    assign mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);

    // Assign mux_in[1] based on the Karnaugh map
    assign mux_in[1] = ~c & ~d;

    // Assign mux_in[2] based on the Karnaugh map
    assign mux_in[2] = c & d;

    // Assign mux_in[3] based on the Karnaugh map
    assign mux_in[3] = (~c & ~d) | (c & ~d) | (c & d);

endmodule