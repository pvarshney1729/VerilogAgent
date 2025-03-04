```verilog
module TopModule(
    input logic clk,             // 1-bit clock input, active on negative edge
    input logic reset,           // 1-bit active high synchronous reset
    input logic [7:0] d,         // 8-bit data input
    output logic [7:0] q         // 8-bit data output
);

    always @(negedge clk) begin
        if (reset) begin
            q <= 8'b00110100; // Reset state to 0x34
        end else begin
            q <= d; // Capture input data
        end
    end

endmodule
```