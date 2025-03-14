[BEGIN]
```verilog
module TopModule (
    input logic a,  // Input signal a (1-bit)
    input logic b,  // Input signal b (1-bit)
    output logic out // Output signal out (1-bit)
);
    always @(*) begin
        out = ~(a ^ b); // XNOR operation
    end
endmodule
```
[DONE]