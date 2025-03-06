[BEGIN]
```verilog
module TopModule (
    input logic [1023:0] in,
    input logic [7:0] sel,
    output logic [3:0] out
);

    always @(*) begin
        out = in[(4'b0000 + (sel * 4'b0100) + 4'b0011):(4'b0000 + (sel * 4'b0100))];
    end

endmodule
```
[DONE]