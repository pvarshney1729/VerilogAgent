module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Continuous assignment for XOR operation
    assign out_assign = a ^ b;

    // Combinational always block for XOR operation
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block for XOR operation with flip-flop
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule