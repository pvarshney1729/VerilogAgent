[BEGIN]
```verilog
module TopModule (
    input logic [3:0] x,   // 4-bit input vector x, where x[0] is the LSB and x[3] is the MSB
    output logic f         // 1-bit output f
);

always @(*) begin
    f = (x[3] & x[2]) | (x[1] & ~x[0]) | (~x[3] & ~x[1] & x[2]);
end

endmodule
```
[DONE]