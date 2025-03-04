module TopModule (
    input logic c,       // Single-bit input
    input logic d,       // Single-bit input
    input logic a,       // Single-bit selector input for 4-to-1 mux
    input logic b,       // Single-bit selector input for 4-to-1 mux
    output logic [3:0] mux_in // 4-bit output to the 4-to-1 multiplexer
);

    assign mux_in[0] = (~c & ~d) | (c & d); // mux_in[0] = ¬c·¬d + c·d
    assign mux_in[1] = 1'b0;                 // mux_in[1] = 0
    assign mux_in[2] = c & d;                 // mux_in[2] = c·d
    assign mux_in[3] = (~c & d) | (c & ~d);  // mux_in[3] = ¬c·d + c·¬d

endmodule