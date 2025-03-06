```verilog
module TopModule (
    input wire d,
    input wire ena,
    output reg q
);
    always @ (d or ena) begin
        if (ena) begin
            q <= d;
        end
    end
endmodule
```