module TopModule (
    input logic clk,       // Clock signal, triggers on positive edge
    input logic reset,     // Asynchronous reset signal
    input logic x,         // Single-bit unsigned input
    output logic z         // Single-bit unsigned output
);

    // Internal signals for D flip-flop outputs
    logic xor_ff_out, and_ff_out, or_ff_out;

    // XOR, AND, OR gate outputs
    logic xor_out, and_out, or_out;

    // XOR gate logic
    assign xor_out = x ^ xor_ff_out;

    // AND gate logic
    assign and_out = x & ~and_ff_out;

    // OR gate logic
    assign or_out = x | ~or_ff_out;

    // D flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            xor_ff_out <= 1'b0;
            and_ff_out <= 1'b0;
            or_ff_out <= 1'b0;
        end else begin
            xor_ff_out <= xor_out;
            and_ff_out <= and_out;
            or_ff_out <= or_out;
        end
    end

    // NOR gate combining the outputs of the flip-flops
    assign z = ~(xor_ff_out | and_ff_out | or_ff_out);

endmodule