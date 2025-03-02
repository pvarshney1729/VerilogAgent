module xor_example (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff,
    input logic clk
);

    // Combinational logic for out_assign
    assign out_assign = a ^ b;

    // Combinational logic for out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic for out_always_ff
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule