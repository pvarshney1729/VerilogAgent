module TopModule(
    input  logic a,
    input  logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // AND gate using assign statement
    assign out_assign = a & b;

    // AND gate using combinational always block
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule