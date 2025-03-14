```verilog
// [BEGIN]
module TopModule (
    input logic d,           // Data input for the D latch
    input logic ena,         // Enable input (active high)
    output logic q           // Output of the D latch
);

    // Initial state of output 'q'
    initial begin
        q = 1'b0; // Initial state
    end

    // Always Block Implementation
    always @(*) begin
        if (ena) begin
            q = d; // Capture data input 'd' when 'ena' is high
        end
        // If 'ena' is low, 'q' retains its previous value
    end

endmodule
// [DONE]
```