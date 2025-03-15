module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal state registers
    logic p_next, q_next;

    // Sequential logic for state update
    always_ff @(posedge clock) begin
        p <= p_next;
        q <= q_next;
    end

    // Combinational logic for next state
    always_comb begin
        // Default assignments
        p_next = p;
        q_next = q;

        // Logic for p
        if (a) begin
            p_next = 1;
        end else begin
            p_next = 0;
        end

        // Logic for q
        if (p == 0 && p_next == 1) begin
            q_next = 1;
        end else if (p == 1 && p_next == 0) begin
            q_next = 0;
        end
    end

endmodule