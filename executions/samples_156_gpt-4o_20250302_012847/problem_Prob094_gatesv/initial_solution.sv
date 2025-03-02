module TopModule (
    input logic clk,
    input logic reset,
    input logic a,
    input logic b,
    output logic out_both,
    output logic out_any,
    output logic out_different
);

    // Combinational logic for outputs
    always @(*) begin
        out_both = a & b;
        out_any = a | b;
        out_different = a ^ b;
    end

endmodule