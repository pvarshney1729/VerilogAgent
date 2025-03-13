```
[BEGIN]
module TopModule (
    input logic [3:0] x,  // 4-bit input x
    output logic f        // 1-bit output f
);

always @(*) begin
    f = (x[3] & ~1'b0) | (x[2] & x[1]) | (x[3] & x[2]);
end

endmodule
[DONE]
```