[BEGIN]
```verilog
module TopModule (
    input        sel,
    input  [7:0] a,
    input  [7:0] b,
    output logic [7:0] out
);

    always @(*) begin
        if (sel == 1'b0) 
            out = a;
        else 
            out = b;
    end

endmodule
```
[DONE]