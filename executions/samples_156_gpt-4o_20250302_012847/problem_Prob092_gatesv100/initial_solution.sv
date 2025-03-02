module combinational_logic (
    input logic a,
    input logic b,
    output logic out_a,
    output logic out_b,
    output logic out_both,
    output logic out_different
);

    // Combinational logic for outputs
    always @(*) begin
        out_a = a;
        out_b = b;
        out_both = a & b;
        out_different = a ^ b;
    end

endmodule