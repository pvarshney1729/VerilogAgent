```verilog
module TopModule (
    input logic clk,        // Clock input, negative edge triggered
    input logic reset,      // Active high synchronous reset
    input logic [7:0] d,    // 8-bit data input, unsigned
    output logic [7:0] q    // 8-bit data output, unsigned
);

    always @(negedge clk) begin
        if (reset) 
            q <= 8'b00110100;  // Reset state
        else 
            q <= d;            // Normal operation
    end

endmodule
```