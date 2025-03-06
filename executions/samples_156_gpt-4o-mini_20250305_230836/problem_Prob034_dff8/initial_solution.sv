```verilog
module TopModule (
    input  logic clk,           // Clock signal, positive edge-triggered
    input  logic reset,         // Synchronous reset signal
    input  logic [7:0] d,       // 8-bit data input vector
    output logic [7:0] q        // 8-bit data output vector
);

always @(posedge clk) begin
    if (reset) begin
        q <= 8'b00000000; // Reset state
    end else begin
        q <= d;           // Capture input
    end
end

endmodule
```