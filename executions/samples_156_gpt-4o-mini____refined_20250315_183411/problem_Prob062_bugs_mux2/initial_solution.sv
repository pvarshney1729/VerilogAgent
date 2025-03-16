[BEGIN]
```verilog
module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output logic [7:0] out
);

    always @(*) begin
        out = (sel) ? b : a;
    end

endmodule
```
[DONE]