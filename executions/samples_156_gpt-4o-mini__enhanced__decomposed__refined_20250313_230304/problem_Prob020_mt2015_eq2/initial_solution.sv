[BEGIN]
```verilog
module TopModule (
    input logic [1:0] A, // 2-bit input representing first operand
    input logic [1:0] B, // 2-bit input representing second operand
    output logic z       // 1-bit output indicating equality of A and B
);
    always @(*) begin
        z = (A == B) ? 1'b1 : 1'b0; // z is 1 if A equals B, otherwise z is 0
    end
endmodule
```
[DONE]