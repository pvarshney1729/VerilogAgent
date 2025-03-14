```
[BEGIN]
module TopModule (
    input logic clk,          // Clock input (1-bit, unsigned)
    input logic d,            // Data input (1-bit, unsigned)
    input logic r,            // Active high synchronous reset input (1-bit, unsigned)
    output logic q            // Data output (1-bit, unsigned)
);

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0;          // Synchronous reset: output q is set to 0
    end else begin
        q <= d;             // Capture the value of d on the rising edge of clk
    end
end

endmodule
[DONE]
```