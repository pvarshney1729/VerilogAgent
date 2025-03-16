[BEGIN]
module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    logic p_reg, q_reg;
    logic a_d;

    always_ff @(posedge clock) begin
        a_d <= a; // delay a by one cycle
        if (a_d) begin
            p_reg <= 1'b1;
        end else begin
            p_reg <= 1'b0;
        end
    end

    always_ff @(posedge clock) begin
        if (a_d) begin
            q_reg <= 1'b0;
        end else if (p_reg) begin
            q_reg <= 1'b1;
        end
    end

    assign p = p_reg;
    assign q = q_reg;

endmodule
[DONE]