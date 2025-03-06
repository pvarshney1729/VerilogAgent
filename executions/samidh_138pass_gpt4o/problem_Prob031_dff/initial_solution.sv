```verilog
[BEGIN]
module TopModule (
    input logic clk,    // Clock signal (positive edge-triggered)
    input logic d,      // Data input to the D flip-flop
    input logic reset,  // Synchronous reset signal
    output logic q      // Data output from the D flip-flop
);

// Behavioral Description:
// - The output 'q' is updated with the value of input 'd' on the rising edge of 'clk'.
// - If reset is asserted, 'q' is set to 1'b0.

always @(posedge clk) begin
    if (reset) begin
        q <= 1'b0;  // Reset 'q' to 0 on reset signal
    end else begin
        q <= d;     // Capture the value of 'd' at the rising edge of 'clk'.
    end
end

endmodule
[DONE]
```