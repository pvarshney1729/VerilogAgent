[BEGIN]
module TopModule(
    input logic clock,
    input logic reset,
    input logic a,
    output logic p,
    output logic q
);

logic p_next, q_next, q_reg;

always_ff @(posedge clock) begin
    if (reset) begin
        p <= 1'b0;
        q <= 1'b0;
        q_reg <= 1'b0;
    end else begin
        p <= p_next;
        q <= q_next;
        q_reg <= q;
    end
end

always_comb begin
    p_next = a ? 1'b1 : 1'b0;
    q_next = (p && !a) ? 1'b1 : q_reg;
end

endmodule
[DONE]