```verilog
module TopModule (
    input logic a,     // Input signal a (1-bit)
    input logic b,     // Input signal b (1-bit)
    output logic out   // Output signal out (1-bit)
);

assign out = a & b; // The output 'out' is the logical AND of inputs 'a' and 'b'.

endmodule
```