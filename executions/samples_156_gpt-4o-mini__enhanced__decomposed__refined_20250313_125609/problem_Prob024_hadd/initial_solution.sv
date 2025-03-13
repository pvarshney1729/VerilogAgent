[BEGIN]
```verilog
module TopModule (
    input  logic a,    // First input bit (1-bit)
    input  logic b,    // Second input bit (1-bit)
    output logic sum,  // Output bit representing the sum (1-bit)
    output logic cout   // Output bit representing the carry-out (1-bit)
);

    always @(*) begin
        sum = a ^ b;   // sum is the XOR of a and b
        cout = a & b;  // cout is the AND of a and b
    end

endmodule
```
[DONE]