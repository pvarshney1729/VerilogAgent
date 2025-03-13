```
[BEGIN]
module TopModule (
    input logic in1,  // One-bit input
    input logic in2,  // One-bit input
    output logic out  // One-bit output
);

always @(*) begin
    out = ~(in1 | in2);  // NOR operation
end

endmodule
[DONE]
```