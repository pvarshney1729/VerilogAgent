```verilog
module TopModule (
    input logic in1,
    input logic in2,
    output logic out
);
    always @(*) begin
        out = in1 & ~in2; // ~in2 is equivalent to 1'b1 when in2 is 1'b0
    end
endmodule
```