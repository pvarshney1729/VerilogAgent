module TopModule(
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Using assign statement for XOR
    assign out_assign = a ^ b;

    // Using combinational always block for XOR
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Using clocked always block for XOR
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule