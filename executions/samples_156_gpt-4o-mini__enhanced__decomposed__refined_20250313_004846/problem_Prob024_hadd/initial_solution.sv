[BEGIN]
```verilog
module TopModule (
    input logic a,       // Single-bit input 
    input logic b,       // Single-bit input
    output logic sum,    // Single-bit output representing the sum
    output logic cout    // Single-bit output representing the carry-out
);

always @(*) begin
    sum = a ^ b;        // Logic for sum using XOR
    cout = a & b;      // Logic for cout using AND
end

endmodule
```
[DONE]