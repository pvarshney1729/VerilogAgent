module TopModule(
    input logic clk,
    input logic x,
    output logic z
);

    logic q_xor, q_and, q_or;

    // Sequential logic for D flip-flops
    always @(posedge clk) begin
        q_xor <= x ^ q_xor;     // XOR gate with D flip-flop
        q_and <= x & ~q_and;    // AND gate with D flip-flop
        q_or  <= x | ~q_or;     // OR gate with D flip-flop
    end

    // Combinational logic for NOR gate
    assign z = ~(q_xor | q_and | q_or);

endmodule