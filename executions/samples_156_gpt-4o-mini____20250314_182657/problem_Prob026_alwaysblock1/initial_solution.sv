module TopModule (
    input logic a,
    input logic b,
    output logic out_assign,
    output logic out_alwaysblock
);

    // Assign statement for AND operation
    assign out_assign = a & b;

    // Combinational always block for AND operation
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule