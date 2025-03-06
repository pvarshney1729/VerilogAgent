module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic Q0, Q1, Q2;
    logic D0, D1, D2;

    // Combinational logic for D flip-flop inputs
    always @(*) begin
        D0 = x ^ Q0;
        D1 = x & ~Q1;
        D2 = x | ~Q2;
    end

    // Sequential logic for D flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            Q0 <= 1'b0;
            Q1 <= 1'b0;
            Q2 <= 1'b0;
        end else begin
            Q0 <= D0;
            Q1 <= D1;
            Q2 <= D2;
        end
    end

    // Output logic
    assign z = ~(Q0 | Q1 | Q2);

endmodule