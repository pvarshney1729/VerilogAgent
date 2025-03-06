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
    end

    initial begin
        q = 1'b0; // Initial state of output q
    end

endmodule
```
[DONE]