```
[BEGIN]
module TopModule (
    input logic x,  // 1-bit input
    input logic y,  // 1-bit input
    output logic z  // 1-bit output
);
    always @(*) begin
        z = (x ^ y) & x;  // Implementing the boolean function
    end
endmodule
[DONE]
```