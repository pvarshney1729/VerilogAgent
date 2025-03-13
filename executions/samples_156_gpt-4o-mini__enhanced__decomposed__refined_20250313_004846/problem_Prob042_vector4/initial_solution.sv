[BEGIN]
```verilog
module TopModule(
    input signed [7:0] in,
    output logic signed [31:0] out
);

    always @(*) begin
        out = { {24{in[7]}}, in };
    end

endmodule
```
[DONE]