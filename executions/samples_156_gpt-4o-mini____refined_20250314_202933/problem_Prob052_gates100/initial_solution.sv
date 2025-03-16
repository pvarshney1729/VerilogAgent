```
[BEGIN]
module TopModule (
    input logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    always @(*) begin
        out_and = &in;      // 100-input AND
        out_or = |in;       // 100-input OR
        out_xor = ^in;      // 100-input XOR
    end

endmodule
[DONE]
```