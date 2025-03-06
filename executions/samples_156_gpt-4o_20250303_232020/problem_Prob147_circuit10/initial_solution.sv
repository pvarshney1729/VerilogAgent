module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic q,
    output logic state
);

    // Initial conditions
    initial begin
        state = 1'b0;
        q = 1'b0;
    end

    always_ff @(posedge clk) begin
        if (b) begin
            q <= ~q; // Toggle q when b is high
        end

        if (a) begin
            state <= a & b; // Update state based on a and b
        end
    end

endmodule