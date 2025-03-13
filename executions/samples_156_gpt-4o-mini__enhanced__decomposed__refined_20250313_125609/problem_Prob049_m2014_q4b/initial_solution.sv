[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic ar,
    input logic d,
    output logic q
);
    always @(posedge clk) begin
        if (ar) begin
            q <= 1'b0; // Asynchronous reset
        end else begin
            q <= d; // Capture data on rising edge of clk
        end
    end
endmodule
```
[DONE]