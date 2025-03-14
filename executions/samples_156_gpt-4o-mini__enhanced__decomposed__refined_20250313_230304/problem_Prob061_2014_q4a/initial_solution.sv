[BEGIN]
module TopModule (
    input logic clk,     // Clock input, positive edge triggered
    input logic w,      // Input from the previous stage (1 bit)
    input logic [1:0] R,// Value to load (2 bits, explicitly defined for potential future extension)
    input logic E,      // Enable shift signal (1 bit)
    input logic L,      // Load signal (1 bit)
    output logic Q      // Output (1 bit)
);

// Always block triggered on the positive edge of the clock
always_ff @(posedge clk) begin
    if (L) begin
        Q <= R[0]; // Load operation: when L is high, load the value from R
    end else if (E) begin
        Q <= w; // Shift operation: when E is high, shift the value from the previous stage
    end 
    // If both L and E are low, maintain the current state of Q
end

// Initialize Q to 0 on reset
initial begin
    Q = 1'b0; // Initial state of output Q is defined as 0
end

endmodule
[DONE]