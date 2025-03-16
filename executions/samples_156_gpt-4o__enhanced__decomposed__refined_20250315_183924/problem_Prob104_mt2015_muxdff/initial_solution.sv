[BEGIN]
module TopModule (
    input logic clk,
    input logic L,
    input logic q_in,
    input logic r_in,
    output logic Q
);

    logic mux_out;

    always_comb begin
        mux_out = L ? r_in : q_in;
    end

    always @(posedge clk) begin
        Q <= mux_out;
    end

endmodule
[DONE]