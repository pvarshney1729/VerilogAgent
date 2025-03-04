module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Internal state to track the previous value of `p`
    logic prev_p;

    // Initialize outputs and internal state
    initial begin
        p = 1'b0;
        q = 1'b0;
        prev_p = 1'b0;
    end

    // Sequential logic for `p` and `q`
    always_ff @(posedge clock) begin
        // Update `p` based on the previous value of `a`
        p <= a;

        // Update `q` based on the previous and current value of `p`
        if (prev_p && p) begin
            q <= 1'b1;
        end else begin
            q <= 1'b0;
        end

        // Store the current value of `p` for the next cycle
        prev_p <= p;
    end

endmodule