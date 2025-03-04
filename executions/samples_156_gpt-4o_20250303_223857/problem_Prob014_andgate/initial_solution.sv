module TopModule (
    input logic a,  // 1-bit input, unsigned
    input logic b,  // 1-bit input, unsigned
    output logic out // 1-bit output, unsigned
);

    // Combinational logic for 2-input AND gate
    always @(*) begin
        out = a & b;
    end

endmodule