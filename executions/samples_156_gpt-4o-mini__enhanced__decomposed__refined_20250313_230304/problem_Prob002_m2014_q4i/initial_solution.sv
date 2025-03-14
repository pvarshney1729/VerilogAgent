[BEGIN]
```verilog
module TopModule (
    output logic out           // 1-bit output signal, logic low
);
    always @(*) begin
        out = 1'b0;           // Continuously drive out to logic low
    end
endmodule
```
[DONE]