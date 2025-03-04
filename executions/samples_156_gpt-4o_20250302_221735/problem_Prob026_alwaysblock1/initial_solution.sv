module TopModule (
    input logic a,            // One-bit input, unsigned
    input logic b,            // One-bit input, unsigned
    output logic out_assign,  // One-bit output using assign
    output logic out_alwaysblock // One-bit output using always block
);

// AND gate using assign statement
assign out_assign = a & b;

// AND gate using combinational always block
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule