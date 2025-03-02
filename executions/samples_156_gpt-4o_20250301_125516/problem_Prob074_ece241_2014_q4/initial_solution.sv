module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic xor_out, and_out, or_out;
    logic dff_xor, dff_and, dff_or;

    // XOR Gate Operation
    assign xor_out = x ^ dff_xor;

    // AND Gate Operation
    assign and_out = x & ~dff_and;

    // OR Gate Operation
    assign or_out = x | ~dff_or;

    // Flip-Flop Behavior
    always_ff @(posedge clk) begin
        dff_xor <= xor_out;
        dff_and <= and_out;
        dff_or <= or_out;
    end

    // NOR Gate Operation
    assign z = ~(dff_xor | dff_and | dff_or);

endmodule