```verilog
// [BEGIN]
module TopModule (
    input logic in,   // 1-bit input signal
    output logic out  // 1-bit output signal, result of NOT operation on 'in'
);
    always @(*) begin
        out = ~in;  // Perform bitwise NOT operation on input 'in'
    end
endmodule
// [DONE]
```