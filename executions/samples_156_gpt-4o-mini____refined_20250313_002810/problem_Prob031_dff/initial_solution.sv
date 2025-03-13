[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic d,
    input logic reset,
    output logic q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 1'b0; // Synchronous reset
        end else begin
            q <= d; // D flip-flop behavior
        end
    end

endmodule
```
[DONE]