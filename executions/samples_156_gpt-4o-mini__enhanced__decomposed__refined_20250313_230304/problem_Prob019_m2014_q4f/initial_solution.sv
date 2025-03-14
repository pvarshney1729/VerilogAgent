[BEGIN]
```verilog
module TopModule (
    input logic in1,  // one-bit input
    input logic in2,  // one-bit input
    output logic out   // one-bit output
);
    always @(*) begin
        out = in1 & ~in2;  // AND gate with inverted in2
    end
endmodule
```
[DONE]