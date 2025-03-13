[BEGIN]
```verilog
module TopModule (
    input logic [1:0] A, // 2-bit wide, unsigned. A[1] is MSB, A[0] is LSB.
    input logic [1:0] B, // 2-bit wide, unsigned. B[1] is MSB, B[0] is LSB.
    output logic z
);

always @(*) begin
    z = (A == B) ? 1'b1 : 1'b0;
end

endmodule
```
[DONE]