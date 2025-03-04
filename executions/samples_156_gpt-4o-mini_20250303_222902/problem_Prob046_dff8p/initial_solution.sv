```verilog
module TopModule (
    input logic clk,             // Clock signal
    input logic reset,           // Active high, synchronous reset
    input logic [7:0] d,         // 8-bit input data bus
    output logic [7:0] q          // 8-bit output data bus
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100;       // Set to reset value on reset
    end else begin
        q <= d;                 // Capture input data on falling edge
    end
end

endmodule
```