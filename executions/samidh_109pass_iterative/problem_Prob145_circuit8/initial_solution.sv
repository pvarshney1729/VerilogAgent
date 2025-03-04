module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Initialize outputs to zero
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic with synchronous reset
    always_ff @(posedge clock) begin
        p <= a;
        q <= p;
    end

endmodule