module TopModule (
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    logic a;
    logic b;

    // Assign a and b based on the inputs c and d
    assign a = c;
    assign b = d;

    // Implementing the K-map using multiplexers
    logic mux0, mux1, mux2, mux3;

    // 2-to-1 MUX for mux0 (ab = 00)
    assign mux0 = 1'b0; // K-map value for 00 is 0

    // 2-to-1 MUX for mux1 (ab = 01)
    assign mux1 = a ? 1'b0 : 1'b1; // K-map value for 01 is 1

    // 2-to-1 MUX for mux2 (ab = 11)
    assign mux2 = (a && b) ? 1'b1 : 1'b0; // K-map value for 11 is 1

    // 2-to-1 MUX for mux3 (ab = 10)
    assign mux3 = a ? 1'b1 : 1'b0; // K-map value for 10 is 1

    // 4-to-1 MUX to select the final output
    assign mux_in = {mux3, mux2, mux1, mux0};

endmodule