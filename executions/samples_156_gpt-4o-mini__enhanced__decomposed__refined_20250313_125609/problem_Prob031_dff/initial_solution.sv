[BEGIN]
```verilog
module TopModule (
    input logic clk,     // Clock input, active on the positive edge
    input logic d,       // Data input for the flip-flop
    input logic reset,   // Synchronous reset input (active-high)
    output logic q       // Output of the flip-flop
);

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0; // Reset state
    end else begin
        q <= d; // Normal operation
    end
end

// Initial state definition
initial begin
    q = 1'b0; // Ensure initial state is defined
end

endmodule
```
[DONE]