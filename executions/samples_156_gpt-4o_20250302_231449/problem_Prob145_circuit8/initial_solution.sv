module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal register to hold the previous state of p
    logic p_reg;

    // Initial block to set initial states for simulation
    initial begin
        p = 1'b0;
        q = 1'b0;
        p_reg = 1'b0;
    end

    // Sequential logic for p and q
    always_ff @(posedge clock) begin
        p_reg <= p; // Store the current state of p
        p <= a;     // Update p based on input a
        q <= p_reg; // Update q based on the previous state of p
    end

endmodule