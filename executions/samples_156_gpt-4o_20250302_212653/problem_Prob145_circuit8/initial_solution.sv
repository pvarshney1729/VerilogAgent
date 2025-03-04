module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);
    logic p_next, q_next;

    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    always @(posedge clock) begin
        p <= p_next;
        q <= q_next;
    end

    always @(*) begin
        if (a) begin
            p_next = 1'b1;
        end else begin
            p_next = 1'b0;
        end

        if (p && !a) begin
            q_next = 1'b1;
        end else begin
            q_next = 1'b0;
        end
    end
endmodule