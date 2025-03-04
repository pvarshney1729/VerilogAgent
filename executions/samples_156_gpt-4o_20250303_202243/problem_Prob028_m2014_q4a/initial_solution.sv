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
        // else retain q
    end
endmodule
```