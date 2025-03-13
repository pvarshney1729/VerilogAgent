[BEGIN]
```verilog
module TopModule (
    input logic clk,      // Clock input for synchronous reset
    input logic rst_n,    // Active-low reset signal
    input logic in,       // One-bit input signal
    output logic out      // One-bit output signal
);

// Combinational Logic with Synchronous Reset
always @(*) begin
    if (!rst_n) begin
        out = 1'b0;      // Reset output to 0 on active-low reset
    end else begin
        out = in;        // Assign input to output
    end
end

endmodule
```
[DONE]