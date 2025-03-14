[BEGIN]
```verilog
module TopModule (
    input logic clk,                 // Clock signal (positive edge triggered)
    input logic reset,               // Active high synchronous reset
    output logic [3:0] q             // 4-bit output representing the counter value
);

always @(posedge clk) begin
    if (reset) begin
        q <= 4'b0000; // Reset counter to 0
    end else begin
        if (q < 4'd9) begin
            q <= q + 1; // Increment counter
        end else begin
            q <= 4'b0000; // Roll over to 0
        end
    end
end

endmodule
```
[DONE]