module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    assign mux_in[0] = d;
    assign mux_in[1] = c & ~d;
    assign mux_in[2] = c;
    assign mux_in[3] = c | d;

endmodule