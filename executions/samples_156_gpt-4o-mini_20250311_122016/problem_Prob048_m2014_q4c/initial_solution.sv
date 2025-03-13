[BEGIN]
```verilog
module TopModule (
    input logic clk,  // Clock signal, positive edge-triggered
    input logic d,    // Data input signal
    input logic r,    // Active high synchronous reset signal
    output logic q    // Output signal
);

always @(posedge clk) begin
    if (r) begin
        q <= 1'b0;  // Reset output to 0 on reset
    end else begin
        q <= d;     // Transfer data input to output
    end
end

endmodule
```
[DONE]