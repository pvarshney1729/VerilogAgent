```verilog
module TopModule (
    input wire clk,     // Clock signal, positive edge-triggered
    input wire in,      // Single-bit input signal
    output reg out      // Single-bit output, driven by the D flip-flop
);

    always @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
```