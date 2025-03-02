module TopModule (
    input logic clk,
    input logic x,
    output logic Z
);

    logic Q1, Q2, Q3;
    logic D1, D2, D3;

    // D flip-flops with asynchronous reset
    always @(posedge clk or negedge clk) begin
        if (!clk) begin
            Q1 <= 1'b0;
            Q2 <= 1'b0;
            Q3 <= 1'b0;
        end else begin
            Q1 <= D1;
            Q2 <= D2;
            Q3 <= D3;
        end
    end

    // Combinational logic
    always @(*) begin
        D1 = x ^ Q1;
        D2 = x & ~Q2;
        D3 = x | ~Q3;
    end

    // Output logic
    assign Z = ~(Q1 | Q2 | Q3);

endmodule