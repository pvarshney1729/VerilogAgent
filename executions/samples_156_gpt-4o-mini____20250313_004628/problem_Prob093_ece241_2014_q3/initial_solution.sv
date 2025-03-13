module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a, b;
    logic mux0, mux1, mux2, mux3;

    // Assign a and b based on c and d
    assign a = c;
    assign b = d;

    // Implementing the K-map using multiplexers
    // mux0 = ab = 00 -> 0
    assign mux0 = 1'b0; // K-map value for ab = 00

    // mux1 = ab = 01 -> 1
    assign mux1 = 1'b1; // K-map value for ab = 01

    // mux2 = ab = 11 -> 1
    assign mux2 = 1'b1; // K-map value for ab = 11

    // mux3 = ab = 10 -> 1
    assign mux3 = 1'b1; // K-map value for ab = 10

    // Connect mux outputs to mux_in
    assign mux_in[0] = mux0; // ab = 00
    assign mux_in[1] = mux1; // ab = 01
    assign mux_in[2] = mux2; // ab = 11
    assign mux_in[3] = mux3; // ab = 10

endmodule