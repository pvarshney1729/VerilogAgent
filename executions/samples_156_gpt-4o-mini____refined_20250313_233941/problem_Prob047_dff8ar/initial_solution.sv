[BEGIN]
```verilog
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (areset) begin
            q <= 8'b0;  // Asynchronous reset
        end else begin
            q <= d;     // D flip-flop behavior
        end
    end

endmodule
```
[DONE]