```verilog
[BEGIN]
module TopModule (
    input logic a,         // Input signal a (1-bit, unsigned)
    input logic b,         // Input signal b (1-bit, unsigned)
    output logic out       // Output signal out (1-bit, unsigned)
);

always @(*) begin
    out = ~(a | b); // Logical NOR operation
end

endmodule
[DONE]
```