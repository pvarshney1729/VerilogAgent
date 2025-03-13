```
[BEGIN]
module TopModule (
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic XNOR_out;

    always @(*) begin
        XNOR_out = ~(in1 ^ in2);
        out = XNOR_out ^ in3;
    end

endmodule
[DONE]
```