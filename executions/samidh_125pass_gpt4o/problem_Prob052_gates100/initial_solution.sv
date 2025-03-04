module TopModule(
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    // Combinational logic for AND, OR, and XOR reductions
    always @(*) begin
        out_and = &in;  // AND reduction
        out_or = |in;   // OR reduction
        out_xor = ^in;  // XOR reduction
    end

endmodule