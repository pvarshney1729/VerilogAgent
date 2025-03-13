```verilog
[BEGIN]
module TopModule (
    input  logic clk,
    input  logic d,
    output logic q
);

    always @(posedge clk) begin
        q <= d;
    end

    always @(negedge clk) begin
        q <= d;
    end

endmodule
[DONE]
```