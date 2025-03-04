module TopModule (
    logic a,             // Single-bit input signal 'a'
    logic b,             // Single-bit input signal 'b'
    logic out_assign,    // Single-bit output 'out_assign' from assign statement
    logic out_alwaysblock // Single-bit output 'out_alwaysblock' from always block
);

// Assign Statement Implementation:
assign out_assign = a & b;

// Combinational Always Block Implementation:
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule