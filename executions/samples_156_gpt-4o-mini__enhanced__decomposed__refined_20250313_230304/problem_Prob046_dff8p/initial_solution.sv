[BEGIN]
```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'h34; // Set to 0x34 on reset
    end else begin
        q <= d; // Capture input d on negative edge of clk
    end
end

endmodule
```
[DONE]