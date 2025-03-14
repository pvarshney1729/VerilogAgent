[BEGIN]
```verilog
module TopModule (
    input logic d,
    input logic ena,
    output logic q
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        else begin
            q = q; // Retain previous value when not enabled
        end
    end

endmodule
```
[DONE]