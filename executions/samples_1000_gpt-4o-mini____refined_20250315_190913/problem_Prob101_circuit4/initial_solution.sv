[BEGIN]
```verilog
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

always @(*) begin
    q = (b & c) | (b & d) | (c & d);
end

endmodule
```
[DONE]