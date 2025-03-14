module TopModule(
    input  logic clk,
    input  logic a,
    input  logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Implement XOR using assign statement
    assign out_assign = a ^ b;

    // Implement XOR using combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Implement XOR using clocked always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule