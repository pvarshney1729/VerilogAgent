module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Combinational logic using assign statement
    assign out_assign = a ^ b;

    // Combinational logic using always_comb block
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Sequential logic with a flip-flop
    always_ff @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule