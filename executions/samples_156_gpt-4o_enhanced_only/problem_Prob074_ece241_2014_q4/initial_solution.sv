module TopModule(
    input logic clk,
    input logic x,
    output logic z
);

    // Internal signals for the D flip-flop outputs
    logic q_xor, q_and, q_or;
    
    // XOR, AND, OR gate outputs
    logic d_xor, d_and, d_or;
    
    // Combinational logic for the D inputs of the flip-flops
    always @(*) begin
        d_xor = x ^ q_xor;
        d_and = x & ~q_and;
        d_or  = x | ~q_or;
    end

    // Sequential logic for the D flip-flops
    always_ff @(posedge clk) begin
        q_xor <= d_xor;
        q_and <= d_and;
        q_or  <= d_or;
    end
    
    // Three-input NOR gate for the output z
    assign z = ~(q_xor | q_and | q_or);

endmodule