module TopModule(
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // Implement AND gate using assign statement
    assign out_assign = a & b;

    // Implement AND gate using always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule