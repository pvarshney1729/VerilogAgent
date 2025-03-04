module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal registers for state
    logic p_next, q_next;

    // Initial block for simulation purposes
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        p <= p_next;
        q <= q_next;
    end

    // Combinational logic to determine next state
    always_comb begin
        p_next = a ? 1'b1 : p;
        q_next = p;
    end

endmodule