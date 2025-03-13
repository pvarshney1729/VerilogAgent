[BEGIN]
```verilog
module TopModule(
    input signed [7:0] a,
    input signed [7:0] b,
    output logic signed [7:0] s,
    output logic overflow
);

    always @(*) begin
        s = a + b;
        overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
    end

endmodule
```
[DONE]