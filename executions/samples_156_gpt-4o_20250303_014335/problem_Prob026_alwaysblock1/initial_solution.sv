module TopModule (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // Implement AND gate using assign statement
    assign out_assign = a & b;

    // Implement AND gate using a combinational always block
    always_comb begin
        out_alwaysblock = a & b;
    end

endmodule