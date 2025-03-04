module TopModule (
    logic a,
    logic b,
    logic out_assign,
    logic out_alwaysblock
);

    // Continuous assignment for out_assign
    assign out_assign = a & b;

    // Combinational always block for out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule