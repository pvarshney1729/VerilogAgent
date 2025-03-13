```
[BEGIN]
module TopModule (
    input logic [7:0] a,
    input logic [7:0] b,
    output logic [7:0] s,
    output logic overflow
);
    always @(*) begin
        s = a + b;
        overflow = ((a[7] == b[7]) && (s[7] != a[7]));
    end
endmodule
[DONE]
```