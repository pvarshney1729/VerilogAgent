```verilog
module TopModule(
    input logic d,    // Data input (1-bit, unsigned)
    input logic ena,  // Enable signal (1-bit, unsigned, active-high)
    output logic q    // Data output (1-bit, unsigned)
);

    always @(*) begin
        if (ena) begin
            q = d; // Latch follows input when enabled
        end
        // If not enabled, q holds its previous value
    end

endmodule
```