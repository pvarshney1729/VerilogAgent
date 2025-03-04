module TopModule (
    input logic a,            // Single-bit input, unsigned
    input logic b,            // Single-bit input, unsigned
    output logic out_assign,  // Single-bit output for assign-based AND, unsigned
    output logic out_alwaysblock // Single-bit output for always block AND, unsigned
);

    // Assign-based Implementation
    assign out_assign = a & b;

    // Always Block Implementation
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule