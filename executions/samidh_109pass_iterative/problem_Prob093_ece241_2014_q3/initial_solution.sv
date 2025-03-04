module TopModule (
    input wire c,           // Input signal 'c', 1-bit width
    input wire d,           // Input signal 'd', 1-bit width
    output wire [3:0] mux_in // 4-bit output vector for multiplexer inputs
);

    // Assign the logic for each mux_in bit based on the Karnaugh map
    assign mux_in[0] = (~c & ~d);
    assign mux_in[1] = (c & ~d);
    assign mux_in[2] = (c & d);
    assign mux_in[3] = (~c & d);

endmodule