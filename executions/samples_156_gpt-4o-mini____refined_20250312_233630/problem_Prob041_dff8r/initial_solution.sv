[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000; // Synchronous reset to zero
        end else begin
            q <= d; // D flip-flop behavior
        end
    end

endmodule
```
[DONE]