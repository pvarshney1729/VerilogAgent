```
[BEGIN]
module TopModule (
    logic clk,   // Clock signal
    logic d,     // Data input
    logic r,     // Synchronous reset
    logic q      // Data output
);

// Initial state
initial begin
    q = 1'b0;
end

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Reset output
    end else begin
        q <= d;    // Latch data
    end
end

endmodule
[DONE]
```