```verilog
[BEGIN]
module TopModule (
    input logic in1,
    input logic in2,
    input logic in3,
    output logic out
);

    always @(*) begin
        out = ~({1'b0} ^ {in1, in2}) ^ in3; // This line is corrected for constant size
    end

endmodule
[DONE]
```