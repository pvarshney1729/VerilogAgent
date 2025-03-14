module TopModule (
    input logic clk,      // Clock input
    input logic w,        // Input from the previous stage (1-bit)
    input logic R,        // Load input value (1-bit)
    input logic E,        // Enable shift (1-bit)
    input logic L,        // Load signal (1-bit)
    output logic Q        // Output (1-bit)
);

always @(posedge clk) begin
    if (L) begin
        Q <= R;          // Load operation
    end else if (E) begin
        Q <= w;          // Shift operation
    end
    // If both L and E are low, Q retains its previous state (hold)
end

endmodule