[BEGIN]
```verilog
module TopModule (
    input logic [255:0] in,
    input logic [7:0] sel,
    output logic out
);

    always @(*) begin
        out = in[sel]; // This is correct as it uses sel to index in
    end

endmodule
```
[DONE]