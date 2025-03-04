module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    // Internal flip-flop outputs
    logic xor_ff_output, and_ff_output, or_ff_output;

    // XOR Path
    logic xor_output;
    always_ff @(posedge clk) begin
        xor_output <= x ^ xor_ff_output;
    end

    // AND Path
    logic and_output;
    always_ff @(posedge clk) begin
        and_output <= x & ~and_ff_output;
    end

    // OR Path
    logic or_output;
    always_ff @(posedge clk) begin
        or_output <= x | ~or_ff_output;
    end

    // D flip-flops for storing the outputs
    always_ff @(posedge clk) begin
        xor_ff_output <= xor_output;
        and_ff_output <= and_output;
        or_ff_output <= or_output;
    end

    // NOR gate for final output
    assign z = ~(xor_ff_output | and_ff_output | or_ff_output);

endmodule