module TopModule (
    input logic a,               // 1-bit input signal 'a'
    input logic b,               // 1-bit input signal 'b'
    output logic out_assign,     // 1-bit output signal for assign-based AND
    output logic out_alwaysblock // 1-bit output signal for always-block-based AND
);

// Combinational Logic using assign statement
assign out_assign = a & b;

// Combinational Logic using always block
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule