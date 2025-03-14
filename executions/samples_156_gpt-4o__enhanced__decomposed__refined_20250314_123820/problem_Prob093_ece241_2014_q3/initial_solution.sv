module TopModule(
    input logic c,
    input logic d,
    input logic a,
    input logic b,
    output logic [3:0] mux_in
);

    always_comb begin
        mux_in[0] = (~c & ~d) | (c & ~d) | (c & d);
        mux_in[1] = 1'b0;
        mux_in[2] = c & d;
        mux_in[3] = (~c & d) | (c & ~d) | (c & d);
    end

endmodule