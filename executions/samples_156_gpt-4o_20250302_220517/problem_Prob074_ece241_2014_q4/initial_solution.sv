module TopModule (
    input logic clk,
    input logic reset_n,  // Active-low asynchronous reset
    input logic x,
    output logic z
);

    // Internal signals for D flip-flop outputs
    logic q1, q2, q3;

    // Combinational logic for D inputs of flip-flops
    logic d1, d2, d3;

    // XOR gate for D1
    assign d1 = x ^ q1;

    // AND gate for D2
    assign d2 = x & ~q2;

    // OR gate for D3
    assign d3 = x | ~q3;

    // Sequential logic for D flip-flops with asynchronous reset
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q1 <= 1'b0;
            q2 <= 1'b0;
            q3 <= 1'b0;
        end else begin
            q1 <= d1;
            q2 <= d2;
            q3 <= d3;
        end
    end

    // NOR gate for output z
    assign z = ~(q1 | q2 | q3);

endmodule