[BEGIN]
```verilog
module TopModule (
    input  logic [7:0] a,  // 8-bit unsigned
    input  logic [7:0] b,  // 8-bit unsigned
    input  logic [7:0] c,  // 8-bit unsigned
    input  logic [7:0] d,  // 8-bit unsigned
    output logic [7:0] min // 8-bit unsigned
);

always @(*) begin
    if (a <= b && a <= c && a <= d)
        min = a;
    else if (b <= a && b <= c && b <= d)
        min = b;
    else if (c <= a && c <= b && c <= d)
        min = c;
    else
        min = d;
end

endmodule
```
[DONE]