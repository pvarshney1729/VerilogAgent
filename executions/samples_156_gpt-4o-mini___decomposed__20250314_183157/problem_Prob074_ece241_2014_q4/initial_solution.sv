module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

logic q_xor, q_and, q_or;

// D Flip-Flops for XOR, AND, OR gates with synchronous reset
always @(posedge clk) begin
    q_xor <= 1'b0; // Reset D flip-flop for XOR
    q_and <= 1'b0; // Reset D flip-flop for AND
    q_or  <= 1'b0; // Reset D flip-flop for OR
end

// D flip-flops to hold the outputs of the gates
always @(posedge clk) begin
    q_xor <= x ^ q_xor;
    q_and <= x & ~q_and;
    q_or  <= x | ~q_or;
end

// Three-input NOR gate
assign z = ~(q_xor | q_and | q_or);

endmodule