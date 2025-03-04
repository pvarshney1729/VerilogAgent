module TopModule (
    input  logic clk,     // Clock signal, positive edge-triggered
    input  logic rst_n,   // Active-low synchronous reset
    input  logic w,       // Input from the previous stage of the shift register
    input  logic R,       // Value to load into the register
    input  logic E,       // Enable signal for shifting
    input  logic L,       // Load signal, high when loading the value R
    output logic Q        // Output to the next stage
);

always @(posedge clk) begin
    if (!rst_n)
        Q <= 1'b0;  // Reset state
    else if (L)
        Q <= R;  // Load operation
    else if (E)
        Q <= w;  // Shift operation
end

endmodule