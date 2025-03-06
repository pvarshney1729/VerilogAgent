```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock signal
    input logic reset,         // Active high synchronous reset
    input logic [7:0] d,       // 8-bit input data bus
    output logic [7:0] q        // 8-bit output data bus
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000;  // Reset q to zero
    end else begin
        q <= d;            // Capture input d into q
    end
end

endmodule
[DONE]
```