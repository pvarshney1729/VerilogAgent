```verilog
[BEGIN]
module TopModule (
    logic a,
    logic b,
    logic c,
    logic d,
    logic q
);
    always @(*) begin
        q = (b & ~a) | (c & ~d) | (c & d);
    end
endmodule
[DONE]
```