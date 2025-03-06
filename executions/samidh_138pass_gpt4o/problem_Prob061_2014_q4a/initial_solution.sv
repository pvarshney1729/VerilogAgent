```verilog
[BEGIN]
module TopModule (
    input  logic clk,      // Clock signal, triggers on positive edge
    input  logic w,        // Input from the previous stage, 1-bit
    input  logic R,        // Value to load into the shift register, 1-bit
    input  logic E,        // Enable signal for shifting, 1-bit
    input  logic L,        // Load signal, when asserted, loads R into Q, 1-bit
    output logic Q         // Output to the next stage, 1-bit
);

    // Sequential logic for loading and shifting
    always @(posedge clk) begin
        if (L) begin
            Q <= R;  // Load operation
        end else if (E) begin
            Q <= w;  // Shift operation
        end
        // Hold state is implicit when neither L nor E is asserted
    end

    // Initialize Q to 0
    initial begin
        Q = 1'b0; // Set initial state of Q to 0
    end

endmodule
[DONE]
```