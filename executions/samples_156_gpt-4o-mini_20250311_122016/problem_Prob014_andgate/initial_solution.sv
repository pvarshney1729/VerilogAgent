[BEGIN]
module TopModule (
    input logic a,  // 1-bit input, unsigned
    input logic b,  // 1-bit input, unsigned
    output logic out  // 1-bit output, unsigned
);
    always @(*) begin
        out = a & b;  // Logical AND operation
    end
endmodule
[DONE]