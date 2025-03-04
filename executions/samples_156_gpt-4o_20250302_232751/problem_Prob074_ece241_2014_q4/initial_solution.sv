module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // Internal signals for D flip-flop outputs
    logic q_xor, q_and, q_or;

    // Combinational logic for gate outputs
    logic xor_out, and_out, or_out;

    // XOR gate: x XOR q_xor
    assign xor_out = x ^ q_xor;

    // AND gate: x AND ~q_and
    assign and_out = x & ~q_and;

    // OR gate: x OR ~q_or
    assign or_out = x | ~q_or;

    // Sequential logic for D flip-flops
    always_ff @(posedge clk) begin
        if (reset) begin
            q_xor <= 1'b0;
            q_and <= 1'b0;
            q_or <= 1'b0;
        end else begin
            q_xor <= xor_out;
            q_and <= and_out;
            q_or <= or_out;
        end
    end

    // NOR gate: ~(q_xor OR q_and OR q_or)
    assign z = ~(q_xor | q_and | q_or);

endmodule