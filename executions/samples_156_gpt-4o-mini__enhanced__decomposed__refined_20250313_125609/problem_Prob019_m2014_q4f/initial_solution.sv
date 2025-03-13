```
[BEGIN]
module TopModule (
    input logic in1,   // 1-bit unsigned input signal
    input logic in2,   // 1-bit unsigned input signal (this input will be inverted)
    output logic out   // 1-bit unsigned output signal
);
    always @(*) begin
        out = in1 & ~in2; // Combinational logic: AND with inverted in2
    end
endmodule
[DONE]
```