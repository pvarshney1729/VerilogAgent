[BEGIN]
```verilog
module TopModule (
    logic a,
    logic b,
    logic c,
    logic w,
    logic x,
    logic y,
    logic z
);
    always @(*) begin
        w = a;
        x = b;
        y = b;
        z = c;
    end
endmodule
```
[DONE]