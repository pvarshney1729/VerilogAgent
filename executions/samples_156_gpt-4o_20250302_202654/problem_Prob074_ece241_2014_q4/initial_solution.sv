module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    // Internal signals for D flip-flop outputs
    logic q_xor, q_and, q_or;

    // XOR, AND, OR gate outputs
    logic xor_out, and_out, or_out;

    // Combinational logic for gates
    always @(*) begin
        xor_out = x ^ q_xor;
        and_out = x & ~q_and;
        or_out  = x | ~q_or;
    end

    // Sequential logic for D flip-flops with synchronous reset
    always_ff @(posedge clk) begin
        if (1'b0) begin
            q_xor <= 1'b0;
            q_and <= 1'b0;
            q_or  <= 1'b0;
        end else begin
            q_xor <= xor_out;
            q_and <= and_out;
            q_or  <= or_out;
        end
    end

    // NOR gate for final output
    assign z = ~(q_xor | q_and | q_or);

endmodule