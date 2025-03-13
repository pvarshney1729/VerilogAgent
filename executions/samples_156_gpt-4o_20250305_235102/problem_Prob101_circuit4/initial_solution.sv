```verilog
[BEGIN]
module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    always @(*) begin
        q = (b & ~a) | (c & (a | ~d));
    end

endmodule
[DONE]
```