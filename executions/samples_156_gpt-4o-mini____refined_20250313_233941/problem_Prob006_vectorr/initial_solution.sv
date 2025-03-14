[BEGIN]
```verilog
module TopModule (
    input logic [7:0] in,
    output logic [7:0] out
);

    always @(*) begin
        out = {in[7:0]};
    end

endmodule
```
[DONE]