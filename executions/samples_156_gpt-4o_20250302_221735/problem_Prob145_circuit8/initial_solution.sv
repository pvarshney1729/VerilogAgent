module TopModule (
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
        p_next = p;
        q_next = q;
        
        if (a) begin
            p_next = 1'b1;
        end else if (p) begin
            p_next = 1'b0;
            q_next = 1'b1;
        end else begin
            q_next = 1'b0;
        end
    end

endmodule