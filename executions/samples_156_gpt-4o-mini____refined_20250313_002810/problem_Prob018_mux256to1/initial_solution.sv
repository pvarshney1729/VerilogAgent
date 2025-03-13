[BEGIN]
```verilog
module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    always @(*) begin
        out = in[sel]; // This line already reads 'sel'
    end

endmodule
```
[DONE]