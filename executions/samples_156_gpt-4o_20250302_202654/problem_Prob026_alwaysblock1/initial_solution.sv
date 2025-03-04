module TopModule (
    input logic a,            // 1-bit input
    input logic b,            // 1-bit input
    output logic out_assign,  // 1-bit output from assign statement
    output logic out_alwaysblock // 1-bit output from always block
);

    // Using assign statement for AND operation
    assign out_assign = a & b;

    // Using always block for AND operation
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule