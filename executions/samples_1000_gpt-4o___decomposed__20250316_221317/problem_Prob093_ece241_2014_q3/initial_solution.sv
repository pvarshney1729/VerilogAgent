module TopModule(
    input logic c,
    input logic d,
    output logic [3:0] mux_in
);

    always @(*) begin
        mux_in[0] = d;         // Directly assign d
        mux_in[1] = 1'b0;      // Directly assign 0
        mux_in[2] = c | d;     // Use a 2-to-1 mux logic: c as select, d as input
        mux_in[3] = 1'b1;      // Directly assign 1
    end

endmodule