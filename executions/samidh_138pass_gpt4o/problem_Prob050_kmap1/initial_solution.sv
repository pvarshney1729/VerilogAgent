```
[BEGIN]
module TopModule (
    input logic a,  // 1-bit input, unsigned
    input logic b,  // 1-bit input, unsigned
    input logic c,  // 1-bit input, unsigned
    output logic out // 1-bit output, unsigned
);

    always @(*) begin
        out = (~a[0] & c[0]) | b[0]; // Use of logic operation with explicit sizes
    end

endmodule
[DONE]
```