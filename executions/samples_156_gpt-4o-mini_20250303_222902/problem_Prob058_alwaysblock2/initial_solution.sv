module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Continuous assignment for XOR
    assign out_assign = a ^ b;

    // Combinational always block for XOR
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block for XOR with flip-flop
    always @(posedge clk) begin
        out_always_ff <= a ^ b; // Initial state assumed low if not reset specified
    end

endmodule