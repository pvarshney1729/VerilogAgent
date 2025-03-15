module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Implementing the logic for each mux_in bit based on the K-map
    always @(*) begin
        // mux_in[0] corresponds to ab = 00
        mux_in[0] = (~c & ~d) | (c & ~d) | (c & d); // Simplified to 1 when c = 1 or d = 1

        // mux_in[1] corresponds to ab = 01
        mux_in[1] = 1'b0; // Always 0

        // mux_in[2] corresponds to ab = 11
        mux_in[2] = c & d; // 1 only when both c and d are 1

        // mux_in[3] corresponds to ab = 10
        mux_in[3] = (~c & d) | (c & ~d) | (c & d); // Simplified to 1 when c = 1 or d = 1
    end

endmodule