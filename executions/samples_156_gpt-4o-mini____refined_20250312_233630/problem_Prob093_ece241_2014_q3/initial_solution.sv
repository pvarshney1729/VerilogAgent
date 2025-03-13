module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a;
    logic b;

    // Assigning a and b based on inputs c and d
    assign a = c;
    assign b = d;

    // Implementing the K-map using multiplexers
    logic mux0, mux1, mux2, mux3;

    // 2-to-1 MUX for mux0 (ab = 00)
    assign mux0 = 1'b0; // Always 0

    // 2-to-1 MUX for mux1 (ab = 01)
    assign mux1 = a ? 1'b0 : 1'b1; // c = 1 when d = 0

    // 2-to-1 MUX for mux2 (ab = 11)
    assign mux2 = (a) ? (b ? 1'b1 : 1'b0) : 1'b1; // c = 1 when d = 1 or c = 1, d = 0

    // 2-to-1 MUX for mux3 (ab = 10)
    assign mux3 = a ? 1'b1 : 1'b0; // c = 1 when d = 0

    // Final 4-to-1 MUX
    assign mux_in = {mux3, mux2, mux1, mux0};

endmodule