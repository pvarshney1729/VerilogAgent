```verilog
module TopModule (
    input wire clk,
    input wire in,
    output reg out
);

    always @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
```