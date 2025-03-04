module TopModule(
    input logic clk,
    input logic x,
    output logic z
);

    // Flip-flop outputs
    logic FF_XOR, FF_AND, FF_OR;

    // Asynchronous reset logic
    initial begin
        FF_XOR = 1'b0;
        FF_AND = 1'b0;
        FF_OR = 1'b0;
    end

    // Sequential logic for D flip-flops
    always_ff @(posedge clk) begin
        FF_XOR <= x ^ FF_XOR;
        FF_AND <= x & ~FF_AND;
        FF_OR <= x | ~FF_OR;
    end

    // Combinational logic for NOR gate
    always_comb begin
        z = ~(FF_XOR | FF_AND | FF_OR);
    end

endmodule