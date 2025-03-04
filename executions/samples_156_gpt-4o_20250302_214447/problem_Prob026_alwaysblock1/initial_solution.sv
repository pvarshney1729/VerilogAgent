module TopModule (
    input logic a, // One-bit input, unsigned
    input logic b, // One-bit input, unsigned
    output logic out_assign, // One-bit output from assign statement, unsigned
    output logic out_alwaysblock // One-bit output from always block, unsigned
);

    // Assign Statement
    assign out_assign = a & b;

    // Combinational Always Block
    always @(*) begin
        out_alwaysblock = a & b; // Evaluate whenever 'a' or 'b' changes
    end

endmodule