```
[BEGIN]
module TopModule (
    input logic [3:0] in,
    output logic out_and,
    output logic out_or,
    output logic out_xor
);

    always @(*) begin
        out_and = in[0] & in[1] & in[2] & in[3];
        out_or  = in[0] | in[1] | in[2] | in[3];
        out_xor = in[0] ^ in[1] ^ in[2] ^ in[3];
    end

endmodule
[DONE]
```