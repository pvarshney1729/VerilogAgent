```verilog
[BEGIN]
module TopModule (
    input logic in,      // Input signal (1-bit)
    output logic out     // Output signal (1-bit)
);

always @(*) begin
    out = ~in; // Output is the logical negation of input
end

endmodule
[DONE]
```