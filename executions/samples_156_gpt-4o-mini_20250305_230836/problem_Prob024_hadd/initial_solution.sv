```verilog
[BEGIN]
module TopModule (
    logic a,
    logic b,
    logic sum,
    logic cout
);
    always @(*) begin
        sum = a ^ b;
        cout = a & b;
    end
endmodule
[DONE]
```