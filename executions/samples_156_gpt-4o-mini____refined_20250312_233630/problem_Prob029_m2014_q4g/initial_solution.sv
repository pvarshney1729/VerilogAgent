[BEGIN]
```verilog
module TopModule (
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);

    always @(*) begin
        logic xnor_out;
        xnor_out = ~(in1 ^ in2); // Two-input XNOR
        out = xnor_out ^ in3;    // Two-input XOR
    end

endmodule
```
[DONE]