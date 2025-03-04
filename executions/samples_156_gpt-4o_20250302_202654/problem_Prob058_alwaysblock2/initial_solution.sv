module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Continuous assignment for out_assign
    assign out_assign = a ^ b;

    // Combinational always block for out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential always block for out_always_ff
    initial begin
        out_always_ff = 1'b0; // Initial state
    end

    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule