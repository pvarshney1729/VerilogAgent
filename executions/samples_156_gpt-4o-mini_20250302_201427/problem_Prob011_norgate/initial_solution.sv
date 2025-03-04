module TopModule (
    input logic a, // Single-bit input
    input logic b, // Single-bit input
    output logic out // Single-bit output
);

    // Combinational logic for NOR operation
    always @(*) begin
        out = ~(a | b);
    end

endmodule