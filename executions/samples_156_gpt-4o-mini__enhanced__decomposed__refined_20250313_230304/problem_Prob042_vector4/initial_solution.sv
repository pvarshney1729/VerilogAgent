```
[BEGIN]
module TopModule (
    input  logic [7:0] in,   // 8-bit input: represents a signed number
    output logic [31:0] out   // 32-bit output: sign-extended output
);

always @(*) begin
    out = { {24{in[7]}}, in }; // Sign extension logic
end

endmodule
[DONE]
```