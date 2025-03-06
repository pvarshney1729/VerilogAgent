[BEGIN]
```verilog
module TopModule (
    input  logic [99:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

always @(*) begin
    out_and = &in;   // 1'b0 or 1'b1
    out_or = |in;    // 1'b0 or 1'b1
    out_xor = ^in;   // 1'b0 or 1'b1
end

endmodule
```
[DONE]