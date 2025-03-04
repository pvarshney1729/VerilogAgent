module TopModule (
    input logic clk,       // Clock input
    input logic x,         // Single-bit input signal
    output logic z         // Single-bit output signal
);

    // Internal signals for D flip-flops
    logic q_xor, q_and, q_or;
    logic d_xor, d_and, d_or;

    // Combinational logic for D flip-flop inputs
    always @(*) begin
        d_xor = x ^ q_xor;
        d_and = x & ~q_and;
        d_or  = x | ~q_or;
    end

    // Sequential logic for D flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        q_xor <= d_xor;
        q_and <= d_and;
        q_or  <= d_or;
    end

    // NOR gate to produce output z
    assign z = ~(q_xor | q_and | q_or);

endmodule