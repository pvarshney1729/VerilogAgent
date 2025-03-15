module TopModule(
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal register to hold the state of p and q
    logic p_reg, q_reg;

    // Assign outputs
    assign p = p_reg;
    assign q = q_reg;

    // Sequential logic for the rising edge of clock
    always_ff @(posedge clock) begin
        if (a) begin
            p_reg <= 1;
        end else begin
            p_reg <= 0;
        end
    end

    // Sequential logic for the falling edge of clock
    always_ff @(negedge clock) begin
        if (a) begin
            q_reg <= p_reg;
        end else begin
            q_reg <= 0;
        end
    end

endmodule