module TopModule (
    input logic clk,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Combinational Logic
    assign out_assign = a ^ b;

    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Sequential Logic with Synchronous Reset
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end

endmodule