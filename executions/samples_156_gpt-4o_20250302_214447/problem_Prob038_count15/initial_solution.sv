```verilog
module TopModule (
    input logic clk,          // Clock signal, triggers on positive edge
    input logic reset,        // Active high, synchronous reset
    output logic [3:0] q      // 4-bit unsigned output, q[3] is MSB, q[0] is LSB
);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0000; // Reset counter to 0
        end else begin
            q <= q + 1;   // Increment counter
        end
    end

endmodule
```