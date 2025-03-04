```verilog
module TopModule (
    input logic clk,  // Clock signal for triggering sequential logic
    input logic w,    // Input from the previous stage of the shift register
    input logic R,    // Value to load into the register when loading is enabled
    input logic E,    // Enable signal for shifting operation
    input logic L,    // Load signal to load the value R
    output logic Q    // Output to the next stage of the shift register
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;  // Load operation has precedence
        end else if (E) begin
            Q <= w;  // Shift operation
        end
        // If neither L nor E are asserted, Q retains its value
    end

endmodule
```