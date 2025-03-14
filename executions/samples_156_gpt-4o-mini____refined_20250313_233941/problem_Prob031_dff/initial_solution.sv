[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic d,
    input logic rst,  // Added reset input
    output logic q
);

    always @(posedge clk) begin
        if (rst) begin
            q <= 1'b0;  // Synchronous reset
        end else begin
            q <= d;
        end
    end

endmodule
```
[DONE]