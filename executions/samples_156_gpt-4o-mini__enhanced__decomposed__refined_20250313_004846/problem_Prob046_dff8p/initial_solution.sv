```verilog
module TopModule (
    input logic clk,             // Clock signal, negative edge-triggered
    input logic reset,           // Active-high synchronous reset
    input logic [7:0] d,         // 8-bit input data bus, bit[0] is LSB
    output logic [7:0] q          // 8-bit output data bus, bit[0] is LSB
);

always @(negedge clk) begin
    if (reset) begin
        q <= 8'b00110100; // Reset q to 0x34
    end else begin
        q <= d; // Capture d into q
    end
end

endmodule
```