module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);
    assign mux_in[0] = (c & ~d);       // cd = 10
    assign mux_in[1] = (~c & ~d);      // cd = 00
    assign mux_in[2] = (c & d) | (c & ~d); // cd = 11 or 10
    assign mux_in[3] = (c & d);        // cd = 11

endmodule