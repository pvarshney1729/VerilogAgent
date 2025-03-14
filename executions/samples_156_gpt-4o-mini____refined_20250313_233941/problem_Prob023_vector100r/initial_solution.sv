[BEGIN]
```verilog
module TopModule (
    input logic [99:0] in,
    output logic [99:0] out
);

    always @(*) begin
        out = {in[99:0]};
    end

endmodule
```
[DONE]