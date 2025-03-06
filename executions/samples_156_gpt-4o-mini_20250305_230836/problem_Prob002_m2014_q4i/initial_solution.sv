[BEGIN]
```verilog
module TopModule(
    output logic out
);
    // Always drive the output to logic low
    always @(*) begin
        out = 1'b0;
    end
endmodule
```
[DONE]