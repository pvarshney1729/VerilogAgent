```
[BEGIN]
module TopModule (
    input logic clk,       // Clock input, positive edge triggered
    input logic w,        // Input from previous stage (1-bit)
    input logic R,        // Reset signal (active high, 1-bit)
    input logic E,        // Enable signal for shift (1-bit)
    input logic L,        // Load signal (active high, 1-bit)
    output logic Q        // Output (1-bit)
);

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (R) begin
            Q <= 1'b0;  // Reset state
        end else if (L) begin
            Q <= R;     // Load value
        end else if (E) begin
            Q <= w;     // Shift in value
        end
        // If none of the conditions are met, Q retains its previous value
    end

endmodule
[DONE]
```