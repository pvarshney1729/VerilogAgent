[BEGIN]
module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic Q_XOR, Q_AND, Q_OR;
    logic D_XOR, D_AND, D_OR;

    // Combinational Logic
    always @(*) begin
        D_XOR = x ^ Q_XOR;
        D_AND = x & ~Q_AND;
        D_OR = x | ~Q_OR;
    end

    // D Flip-Flops with synchronous reset
    always @(posedge clk) begin
        Q_XOR <= D_XOR;
        Q_AND <= D_AND;
        Q_OR <= D_OR;
    end

    // NOR Gate
    assign z = ~(Q_XOR | Q_AND | Q_OR);

endmodule
[DONE]