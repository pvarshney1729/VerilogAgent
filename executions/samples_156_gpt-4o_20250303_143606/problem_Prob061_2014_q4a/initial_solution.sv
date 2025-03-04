```verilog
module TopModule (
    input wire clk,     // Clock signal; triggers on the positive edge
    input wire w,       // Input from the previous stage of the shift register
    input wire R,       // Value to load into the register
    input wire E,       // Enable signal for shifting
    input wire L,       // Load signal; when asserted, R is loaded into Q
    output reg Q        // Output of the register stage
);

    // Initialize Q to 0 at the start of simulation
    initial begin
        Q = 1'b0;
    end

    always @(posedge clk) begin
        if (L) begin
            Q <= R;  // Load operation
        end else if (E) begin
            Q <= w;  // Shift operation
        end
        // If neither L nor E is asserted, Q retains its value
    end

endmodule
```