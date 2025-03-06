```
[BEGIN]
module TopModule (
    input  logic a, // 1-bit input
    input  logic b, // 1-bit input
    input  logic c, // 1-bit input
    output logic out // 1-bit output
);

    always @(*) begin
        out = (a & (~b | ~c)) | (b & c) | (~b & c);
    end

endmodule
[DONE]
```