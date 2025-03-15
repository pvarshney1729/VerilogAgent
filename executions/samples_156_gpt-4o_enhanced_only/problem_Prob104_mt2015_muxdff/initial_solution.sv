module TopModule(
    input wire clk,
    input wire L,
    input wire q_in,
    input wire r_in,
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

    // D flip-flop to store the result of the multiplexer
    always @(posedge clk) begin
        Q <= mux_out;
    end

endmodule