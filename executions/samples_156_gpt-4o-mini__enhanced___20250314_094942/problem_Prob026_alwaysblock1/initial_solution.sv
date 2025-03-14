module TopModule (
    input logic a,              // Input signal 'a' (1-bit, unsigned)
    input logic b,              // Input signal 'b' (1-bit, unsigned)
    output logic out_assign,    // Output signal 'out_assign' (1-bit, unsigned)
    output logic out_alwaysblock // Output signal 'out_alwaysblock' (1-bit, unsigned)
);

// Continuous assignment using assign statement
assign out_assign = a & b;

// Combinational always block
always @(*) begin
    out_alwaysblock = a & b; // Combinational logic to produce 'out_alwaysblock'
end

endmodule