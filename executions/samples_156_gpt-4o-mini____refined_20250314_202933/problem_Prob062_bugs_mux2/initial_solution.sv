[BEGIN]
```verilog
module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output logic [7:0] out
);

    always @(*) begin
        out = (sel == 1'b1) ? b : a; // Explicit size for constant
    end

endmodule
```
[DONE]