module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output logic Q
);

    logic mux_out;

    // 2:1 multiplexer
    always @(*) begin
        if (L) begin
            mux_out = r_in;
        end else begin
            mux_out = q_in;
        end
    end

    // Flip-flop
    always @(posedge clk) begin
        Q <= mux_out;
    end

endmodule