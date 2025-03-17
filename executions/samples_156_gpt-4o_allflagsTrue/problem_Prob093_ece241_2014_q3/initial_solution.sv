module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Implementing the logic for each bit of mux_in using 2-to-1 multiplexers
    assign mux_in[0] = (~d) | (c & d); // Simplified logic for mux_in[0]
    assign mux_in[1] = 0;              // Constant 0
    assign mux_in[2] = c & d;          // Direct AND operation
    assign mux_in[3] = d;              // Simplified logic for mux_in[3]

endmodule