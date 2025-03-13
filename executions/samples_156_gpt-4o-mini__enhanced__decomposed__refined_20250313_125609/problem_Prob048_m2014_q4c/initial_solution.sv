[BEGIN]
```verilog
module TopModule (
    input logic clk,         // Clock input signal
    input logic d,           // Data input signal
    input logic r,           // Active high synchronous reset
    output logic q           // Output signal representing the state of the flip-flop
);

// Synchronous reset D flip-flop
always @(posedge clk) begin
    if (r) begin
        q <= 1'b0; // Reset the output to 0 when r is high
    end else begin
        q <= d;    // Transfer d to q on the clock edge if r is low
    end
end

endmodule
```
[DONE]