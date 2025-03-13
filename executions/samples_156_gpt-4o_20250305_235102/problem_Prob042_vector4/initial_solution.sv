[BEGIN]
```verilog
module TopModule(
    input  logic [7:0] in,  // 8-bit signed input
    output logic [31:0] out // 32-bit signed output
);
    always @(*) begin
        out = {{24{in[7]}}, in}; // Sign-extend in[7] 24 times and concatenate with input
    end
endmodule
```
[DONE]