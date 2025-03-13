```
[BEGIN]
module TopModule (
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

always @(*) begin
    out_and = in[3] & in[2] & in[1] & in[0]; // 1'b0
    out_or  = in[3] | in[2] | in[1] | in[0]; // 1'b0
    out_xor = in[3] ^ in[2] ^ in[1] ^ in[0]; // 1'b0
end

endmodule
[DONE]
```