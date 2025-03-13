[BEGIN]
```verilog
module TopModule (
    input logic in,  // Single-bit input
    output logic out // Single-bit output
);
    always @(*) begin
        out = ~in; // NOT gate implementation
    end
endmodule
```
[DONE]