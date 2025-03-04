module TopModule (
    input logic clock,  // Clock signal, active on rising edge
    input logic a,      // Input signal 'a'
    output logic p,     // Output signal 'p'
    output logic q      // Output signal 'q'
);

    // Internal registers to hold the state of p and q
    logic p_reg, q_reg;

    // Initialize outputs
    initial begin
        p_reg = 1'b0;
        q_reg = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        if (a) begin
            if (!p_reg) begin
                p_reg <= 1'b1;
            end else begin
                q_reg <= 1'b1;
            end
        end else begin
            p_reg <= 1'b0;
        end
    end

    // Assign internal registers to outputs
    assign p = p_reg;
    assign q = q_reg;

endmodule