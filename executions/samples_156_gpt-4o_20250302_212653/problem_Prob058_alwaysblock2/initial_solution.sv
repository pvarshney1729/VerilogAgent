module TopModule (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_always_comb,
    output logic out_always_ff
);

    // Combinational logic using assign
    assign out_assign = a ^ b;

    // Combinational logic using always_comb
    always_comb begin
        out_always_comb = a ^ b;
    end

    // Sequential logic using always_ff
    always_ff @(posedge clk) begin
        if (reset) begin
            out_always_ff <= 1'b0;
        end else begin
            out_always_ff <= out_always_comb;
        end
    end

endmodule