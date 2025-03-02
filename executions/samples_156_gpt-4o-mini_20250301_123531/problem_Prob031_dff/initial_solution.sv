```verilog
module TopModule (
    logic clk,
    logic d,
    logic q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
```