module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic q_xor, q_and, q_or;

    // Initialize all D flip-flops to zero
    initial begin
        q_xor = 1'b0;
        q_and = 1'b0;
        q_or  = 1'b0;
    end

    always @(posedge clk) begin
        q_xor <= x ^ q_xor;     // XOR with the flip-flop's current output
        q_and <= x & ~q_and;    // AND with the flip-flop's complemented output
        q_or  <= x | ~q_or;     // OR with the flip-flop's complemented output
    end

    assign z = ~(q_xor | q_and | q_or); // Three-input NOR gate

endmodule