```
[BEGIN]
module TopModule (
    input logic a,  // 1-bit input
    input logic b,  // 1-bit input
    input logic c,  // 1-bit input
    input logic d,  // 1-bit input
    output logic q  // 1-bit output
);

always @(*) begin
    q = (b & d) | (a & d) | (a & c);
end

endmodule
[DONE]
```