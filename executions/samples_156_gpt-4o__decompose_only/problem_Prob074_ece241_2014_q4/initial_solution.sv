module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    // D flip-flop outputs
    logic q_xor, q_and, q_or;

    // Sequential logic for D flip-flops
    always @(posedge clk) begin
        q_xor <= x ^ q_xor;   // XOR gate with feedback
        q_and <= x & ~q_and;  // AND gate with complemented feedback
        q_or  <= x | ~q_or;   // OR gate with complemented feedback
    end

    // Three-input NOR gate
    assign z = ~(q_xor | q_and | q_or);

endmodule