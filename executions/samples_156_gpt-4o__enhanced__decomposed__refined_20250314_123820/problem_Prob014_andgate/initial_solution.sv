[BEGIN]
module TopModule (
    input  logic a,  // 1-bit input, unsigned
    input  logic b,  // 1-bit input, unsigned
    output logic out // 1-bit output, result of a AND b
);

// Combinational Logic: Perform bitwise AND operation
always @(*) begin
    out = a & b;
end

endmodule
[DONE]