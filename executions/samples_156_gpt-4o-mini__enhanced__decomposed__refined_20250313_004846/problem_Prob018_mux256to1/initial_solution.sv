```
[BEGIN]
module TopModule(
    input  logic [255:0] in,
    input  logic [7:0]   sel,
    output logic         out
);
    always @(*) begin
        out = in[sel]; // No changes needed here
    end
endmodule
[DONE]
```