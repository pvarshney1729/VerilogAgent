module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a, b;
    logic mux1_out, mux2_out;

    // Assign a and b based on c and d
    assign a = c;
    assign b = d;

    // Implementing the K-map using multiplexers
    // mux_in[0] = 0, mux_in[1] = 1, mux_in[2] = 1, mux_in[3] = 1
    // Using 2-to-1 multiplexers to create the necessary inputs for the 4-to-1 mux
    assign mux1_out = (a == 1'b0) ? 1'b0 : 1'b1; // For ab = 01 and ab = 11
    assign mux2_out = (a == 1'b0) ? 1'b1 : 1'b0; // For ab = 10

    assign mux_in[0] = 1'b0; // ab = 00
    assign mux_in[1] = (b == 1'b0) ? 1'b1 : 1'b0; // ab = 01
    assign mux_in[2] = (b == 1'b0) ? 1'b1 : 1'b1; // ab = 11
    assign mux_in[3] = (b == 1'b0) ? 1'b1 : 1'b0; // ab = 10

endmodule