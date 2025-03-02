module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a, b;
    logic mux1_out, mux2_out, mux3_out;

    // Assign a and b based on c and d
    assign a = c;
    assign b = d;

    // 2-to-1 MUX for mux_in[0]
    assign mux_in[0] = (a == 1'b0 && b == 1'b0) ? 1'b0 : 1'b1;

    // 2-to-1 MUX for mux_in[1]
    assign mux_in[1] = (a == 1'b0 && b == 1'b1) ? 1'b0 : 1'b0;

    // 2-to-1 MUX for mux_in[2]
    assign mux_in[2] = (a == 1'b1 && b == 1'b0) ? 1'b1 : 1'b0;

    // 2-to-1 MUX for mux_in[3]
    assign mux_in[3] = (a == 1'b1 && b == 1'b1) ? 1'b1 : 1'b1;

endmodule