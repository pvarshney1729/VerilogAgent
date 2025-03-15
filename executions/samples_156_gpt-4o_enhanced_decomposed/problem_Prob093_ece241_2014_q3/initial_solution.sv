module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    // Implementing the logic for each mux_in based on the Karnaugh map
    always @(*) begin
        mux_in[0] = d;          // mux_in[0] = d
        mux_in[1] = 1'b0;       // mux_in[1] = 0
        mux_in[2] = c & d;      // mux_in[2] = c & d
        mux_in[3] = ~c | d;     // mux_in[3] = ~c | d
    end

endmodule