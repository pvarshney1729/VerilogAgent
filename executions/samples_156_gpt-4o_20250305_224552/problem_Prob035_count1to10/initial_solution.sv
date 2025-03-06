```verilog
module TopModule (
    input logic clk,           // Clock input, positive-edge triggered
    input logic reset,         // Active high synchronous reset
    output logic [3:0] q       // 4-bit output, q[3] is MSB, q[0] is LSB
);

// Module Description:
// This module implements a decade counter that counts from 1 to 10. 
// The counter increments on the positive edge of the clock. 
// When the counter reaches 10, it wraps around to 1. 
// The counter is reset to 1 on an active high reset signal, synchronous with the clock.

always_ff @(posedge clk) begin
    if (reset) begin
        q <= 4'b0001;  // Synchronous reset to 1
    end else begin
        if (q == 4'b1010) begin
            q <= 4'b0001;  // Wrap around to 1 when counter reaches 10
        end else begin
            q <= q + 1'b1; // Increment counter
        end
    end
end

endmodule
```