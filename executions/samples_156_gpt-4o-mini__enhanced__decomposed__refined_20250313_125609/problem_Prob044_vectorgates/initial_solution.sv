```
[BEGIN]
module TopModule (
    input  logic [2:0] a,               // 3-bit input vector a
    input  logic [2:0] b,               // 3-bit input vector b
    output logic [2:0] out_or_bitwise,  // 3-bit output for bitwise OR of a and b
    output logic out_or_logical,         // 1-bit output for logical OR of a and b
    output logic [5:0] out_not           // 6-bit output for NOT of a and b
);

always @(*) begin
    out_or_bitwise = a | b;               // Bitwise OR
    out_or_logical = |{a, b};             // Logical OR
    out_not[5:3] = ~b;                     // Upper half contains NOT of b
    out_not[2:0] = ~a;                     // Lower half contains NOT of a
end

endmodule
[DONE]
```