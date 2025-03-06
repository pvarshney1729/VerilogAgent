```
[BEGIN]
module TopModule (
    input logic in,
    output logic out
);
    always @(*) begin
        out = in;  // Combinational assignment
    end
endmodule
[DONE]
```