```verilog
[BEGIN]
module TopModule (
    input logic a,          // Input bit a (unsigned, 1-bit)
    input logic b,          // Input bit b (unsigned, 1-bit)
    output logic sum,       // Output bit sum (unsigned, 1-bit)
    output logic cout       // Output bit carry-out (unsigned, 1-bit)
);

always @(*) begin
    sum = a ^ b;           // Sum is the XOR of a and b
    cout = a & b;          // Carry-out is the AND of a and b
end

endmodule
[DONE]
```