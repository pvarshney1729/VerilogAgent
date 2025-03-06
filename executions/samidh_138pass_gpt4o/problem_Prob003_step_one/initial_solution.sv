[BEGIN]
```verilog
module TopModule(
    output logic constant_high
);
    // Drive the output constant high
    always @(*) begin
        constant_high = 1'b1;
    end
endmodule
```
[DONE]