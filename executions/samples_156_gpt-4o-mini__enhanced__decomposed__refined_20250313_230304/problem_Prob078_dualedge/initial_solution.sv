```verilog
[BEGIN]
module TopModule (
    input logic clk,   // Clock input (rising and falling edges)
    input logic d,     // Data input (1-bit)
    input logic reset, // Active-high synchronous reset
    output logic q     // Output (1-bit)
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0; // Reset state
    end else begin
        q <= d; // Update output at posedge
    end
end

always @(negedge clk) begin
    if (!reset) begin
        q <= d; // Update output at negedge
    end
end

endmodule
[DONE]
```