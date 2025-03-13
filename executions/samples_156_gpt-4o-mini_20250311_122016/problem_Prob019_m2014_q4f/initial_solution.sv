[BEGIN]
```verilog
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    always @(*) begin
        out = in1 & ~in2; // Using explicit size for constants
    end
endmodule
```
[DONE]