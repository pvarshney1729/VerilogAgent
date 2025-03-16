```verilog
module TopModule (
    input logic clk,                      // Clock signal, triggers on positive edge
    input logic reset,                    // Active high, synchronous reset
    output logic [9:0] q                  // 10-bit counter output, q[9] is MSB, q[0] is LSB
);

    always @(posedge clk) begin
        if (reset)
            q <= 10'b0000000000;         // Reset counter to 0
        else if (q == 10'b1111100111)    // Check if counter reached 999
            q <= 10'b0000000000;         // Wrap back to 0
        else
            q <= q + 1;                  // Increment counter
    end

endmodule
```