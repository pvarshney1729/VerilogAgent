```
[BEGIN]
module TopModule (
    input  logic [1023:0] in,   // 1024-bit input vector
    input  logic [7:0]    sel,  // 8-bit selection input
    output logic [3:0]    out   // 4-bit output
);
    always @(*) begin
        out = in[sel[7:0] * 4 +: 4];  // Ensure 'sel' is treated as 8 bits
    end
endmodule
[DONE]
```