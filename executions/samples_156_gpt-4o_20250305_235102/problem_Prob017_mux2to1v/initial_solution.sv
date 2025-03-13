```verilog
[BEGIN]
module TopModule (
    input logic [99:0] a,  // 100-bit wide input, unsigned, LSB at bit[0]
    input logic [99:0] b,  // 100-bit wide input, unsigned, LSB at bit[0]
    input logic sel,       // 1-bit wide input for selection
    output logic [99:0] out // 100-bit wide output, unsigned, LSB at bit[0]
);

    always @(*) begin
        out = (sel == 1'b1) ? b : a;
    end

endmodule
[DONE]
```