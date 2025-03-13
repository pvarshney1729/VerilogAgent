```
[BEGIN]
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);

    always @(*) begin
        out = in1 & ~in2; // No changes needed in this line as it follows the logic description.
    end

endmodule
[DONE]
```