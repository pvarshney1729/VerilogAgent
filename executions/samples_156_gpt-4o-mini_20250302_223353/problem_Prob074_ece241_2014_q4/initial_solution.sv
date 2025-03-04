module TopModule (
    input logic clk,
    input logic x,
    output logic z
);

    logic xor_ff, and_ff, or_ff;

    // D flip-flops with asynchronous reset
    always @(posedge clk) begin
        xor_ff <= x ^ xor_ff; // XOR operation
        and_ff <= x & ~and_ff; // AND operation
        or_ff <= x | ~or_ff; // OR operation
    end

    // Three-input NOR gate
    assign z = ~(xor_ff | and_ff | or_ff);

endmodule