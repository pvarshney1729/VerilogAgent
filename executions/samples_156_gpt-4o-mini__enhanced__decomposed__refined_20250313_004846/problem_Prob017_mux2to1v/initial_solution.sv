```
[BEGIN]
module TopModule (
    input  logic [99:0] a,
    input  logic [99:0] b,
    input  logic sel,
    output logic [99:0] out
);

    always @(*) begin
        out = sel ? b : a; // When sel is 1, select b; otherwise select a
    end

endmodule
[DONE]
```