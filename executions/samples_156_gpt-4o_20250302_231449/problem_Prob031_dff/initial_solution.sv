```verilog
module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic d,            // 1-bit data input
    input logic reset_n,      // Active-low asynchronous reset
    output logic q            // 1-bit output
);

    // Asynchronous reset implementation
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 1'b0;       // Reset state
        end else begin
            q <= d;          // Capture input on clock's rising edge
        end
    end

endmodule
```