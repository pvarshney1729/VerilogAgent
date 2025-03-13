module TopModule (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // Continuous assignment for AND gate
    assign out_assign = a & b;

    // Combinational always block for AND gate
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule