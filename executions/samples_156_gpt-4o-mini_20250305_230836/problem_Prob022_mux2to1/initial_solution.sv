```
[BEGIN]
module TopModule (
    logic a,
    logic b,
    logic sel,
    logic out
);
    always @(*) begin
        out = sel ? b : a; // Combinational assignment for 2-to-1 MUX
    end
endmodule
[DONE]
```