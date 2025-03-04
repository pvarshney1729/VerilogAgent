module TopModule (
    input logic c,       // 1-bit input signal
    input logic d,       // 1-bit input signal
    input logic a,       // 1-bit selector for the 4-to-1 multiplexer
    input logic b,       // 1-bit selector for the 4-to-1 multiplexer
    output logic [3:0] mux_in // 4-bit output signal connected to the 4-to-1 multiplexer
);

    // Combinational logic for mux_in[0]
    assign mux_in[0] = c & (d | ~d); // Simplified to c

    // Combinational logic for mux_in[1]
    assign mux_in[1] = 1'b0; // Always 0

    // Combinational logic for mux_in[2]
    assign mux_in[2] = c & d;

    // Combinational logic for mux_in[3]
    assign mux_in[3] = (c & d) | (~c & d) | (c & ~d);

endmodule