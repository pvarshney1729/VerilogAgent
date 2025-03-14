module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Implement the logic based on the K-map for mux_in[3:0]
    // mux_in[0] corresponds to ab = 00
    // mux_in[1] corresponds to ab = 01
    // mux_in[2] corresponds to ab = 11
    // mux_in[3] corresponds to ab = 10
    
    always @(*) begin
        mux_in[0] = (~c & d) | (c & ~d) | (c & d);
        mux_in[1] = 1'b0;
        mux_in[2] = c & d;
        mux_in[3] = (~c & d) | (c & d);
    end

endmodule