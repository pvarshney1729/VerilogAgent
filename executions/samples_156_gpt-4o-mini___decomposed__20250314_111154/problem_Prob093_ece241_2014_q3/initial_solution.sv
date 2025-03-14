module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    assign mux_in[0] = 1'b0;        // ab = 00
    assign mux_in[1] = c & ~d;      // ab = 01
    assign mux_in[2] = c & d | ~c & d; // ab = 11
    assign mux_in[3] = ~c & d;      // ab = 10

endmodule