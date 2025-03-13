[BEGIN]
```verilog
module TopModule (
    input logic a,  // Input signal a (1-bit, unsigned)
    input logic b,  // Input signal b (1-bit, unsigned)
    input logic c,  // Input signal c (1-bit, unsigned)
    input logic d,  // Input signal d (1-bit, unsigned)
    output logic out // Output signal out (1-bit, unsigned)
);
    always @(*) begin
        out = (a == 1'b0 && b == 1'b0 && d == 1'b1) || 
              (a == 1'b0 && b == 1'b1 && c == 1'b0 && d == 1'b0) || 
              (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b0) || 
              (a == 1'b1 && b == 1'b0 && c == 1'b0 && d == 1'b0) || 
              (a == 1'b1 && b == 1'b0 && c == 1'b1 && d == 1'b0) || 
              (a == 1'b1 && b == 1'b1 && c == 1'b0 && d == 1'b1) || 
              (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b0);
    end
endmodule
```
[DONE]