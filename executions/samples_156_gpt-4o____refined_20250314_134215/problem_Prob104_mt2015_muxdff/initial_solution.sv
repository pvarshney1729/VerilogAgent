[BEGIN]
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    logic mux_out;

    // 2:1 Multiplexer
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
[DONE]