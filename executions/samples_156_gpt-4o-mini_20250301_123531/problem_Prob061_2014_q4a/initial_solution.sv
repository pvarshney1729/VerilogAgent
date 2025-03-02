```verilog
module TopModule (
    input  logic clk,  // Clock signal, positive edge-triggered
    input  logic w,    // Input from the previous stage of the shift register
    input  logic R,    // Value to load into the shift register
    input  logic E,    // Enable signal for shifting
    input  logic L,    // Load signal to load value R into Q
    output logic Q     // Output to the next stage of the shift register
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R;  // Load value R into Q
        end else if (E) begin
            Q <= w;  // Shift input w into Q
        end
        // If neither L nor E is asserted, Q retains its previous value
    end

endmodule
```