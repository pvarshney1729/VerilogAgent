```verilog
module DLatch (
    input wire d,      // Data input
    input wire ena,    // Enable input
    output reg q       // Data output
);

    initial begin
        q = 1'b0; // Initial state of the output
    end

    always @(*) begin
        if (ena) begin
            q <= d; // Latch data when enabled
        end
        // Retain previous state when not enabled
    end

endmodule
```