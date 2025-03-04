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

    // Combinational logic using always block
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential logic using always block
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule