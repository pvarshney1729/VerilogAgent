```
[BEGIN]
module TopModule (
    input logic [31:0] in,  // 32-bit input vector
    output logic [31:0] out  // 32-bit output vector
);

always @(*) begin
    out[31:24] = in[7:0];   // Assign in[7:0] to out[31:24]
    out[23:16] = in[15:8];  // Assign in[15:8] to out[23:16]
    out[15:8]  = in[23:16]; // Assign in[23:16] to out[15:8]
    out[7:0]   = in[31:24]; // Assign in[31:24] to out[7:0]
end

endmodule
[DONE]
```