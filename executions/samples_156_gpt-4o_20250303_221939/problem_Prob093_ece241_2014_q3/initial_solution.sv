module TopModule (
    input logic c,         // 1-bit input
    input logic d,         // 1-bit input
    output logic [3:0] mux_in // 4-bit output, {mux_in[3], mux_in[2], mux_in[1], mux_in[0]}
);

    always @(*) begin
        // Mapping logic based on the provided K-map
        mux_in[0] = (c == 1'b1 && d == 1'b0) ? 1'b1 : 1'b0;
        mux_in[1] = (c == 1'b0 && d == 1'b0) ? 1'b1 : 1'b0;
        mux_in[2] = (c == 1'b1 && d == 1'b1) || (c == 1'b1 && d == 1'b0) ? 1'b1 : 1'b0;
        mux_in[3] = (c == 1'b0 && d == 1'b0) ? 1'b1 : 1'b0;
    end

endmodule