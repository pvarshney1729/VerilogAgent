```
[BEGIN]
module TopModule (
    input logic a,          // Input signal a (1-bit)
    input logic b,          // Input signal b (1-bit)
    input logic c,          // Input signal c (1-bit)
    input logic d,          // Input signal d (1-bit)
    output logic out        // Output signal out (1-bit)
);
    always @(*) begin
        out = (1'b0 ~& a & ~c) | (1'b0 ~& a & b) | (~b & c & ~d) | (a & c & d) | (a & ~b & c);
    end
endmodule
[DONE]
```