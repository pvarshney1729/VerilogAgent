[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Synchronous reset
        end else begin
            q <= d; // Update output on clock edge
        end
    end

endmodule
```
[DONE]