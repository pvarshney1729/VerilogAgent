module TopModule (
    input logic clock,
    input logic a,
    output logic p,
    output logic q
);

    // Initial states
    initial begin
        p = 1'b0;
        q = 1'b0;
    end

    // Sequential logic for p
    always_ff @(posedge clock) begin
        if (a == 1'b1) begin
            p <= 1'b1;
        end else begin
            p <= 1'b0;
        end
    end

    // Sequential logic for q
    always_ff @(negedge clock) begin
        if (p == 1'b1) begin
            q <= 1'b1;
        end else begin
            q <= 1'b0;
        end
    end

endmodule