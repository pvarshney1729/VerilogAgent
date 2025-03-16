[BEGIN]
```verilog
module TopModule (
    input  logic [7:0] in,
    output logic [31:0] out
);

    always @(*) begin
        out = { {24{in[7]}}, in[7:0] };
    end

endmodule
```
[DONE]