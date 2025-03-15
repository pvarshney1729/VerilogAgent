module TopModule(
    input logic clk,
    input logic x,
    output logic z
);

    // Internal signals for flip-flop outputs
    logic q_xor, q_and, q_or;

    // XOR, AND, OR gate operations
    logic d_xor, d_and, d_or;
    assign d_xor = x ^ q_xor;
    assign d_and = x & ~q_and;
    assign d_or  = x | ~q_or;

    // D flip-flops with positive edge clock triggering
    always_ff @(posedge clk) begin
        q_xor <= d_xor;
        q_and <= d_and;
        q_or  <= d_or;
    end

    // Three-input NOR gate
    assign z = ~(q_xor | q_and | q_or);

    // Initial block for simulation to reset flip-flops to zero
    initial begin
        q_xor = 1'b0;
        q_and = 1'b0;
        q_or  = 1'b0;
    end

endmodule