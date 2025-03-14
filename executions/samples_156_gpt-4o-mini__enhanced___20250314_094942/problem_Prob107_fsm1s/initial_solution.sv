```verilog
module TopModule (
    input  logic clk,           // Clock input (1 bit)
    input  logic reset,         // Active-high synchronous reset (1 bit)
    input  logic in,            // Input signal (1 bit)
    output logic out            // Output signal (1 bit)
);

// State Encoding
typedef enum logic [0:0] {
    B = 1'b0, // State B: out = 1
    A = 1'b1  // State A: out = 0
} state_t;

// State Variables
state_t current_state, next_state;

// Reset Behavior
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= B;  // Reset state
        out <= 1'b1;         // Output in reset state
    end else begin
        current_state <= next_state; // Update state on clock edge
    end
end

// State Transition Logic
always_comb begin
    // Default to hold current state
    next_state = current_state;
    out = (current_state == B) ? 1'b1 : 1'b0; // Output logic

    // State transitions based on input
    case (current_state)
        B: begin
            if (in == 1'b0) begin
                next_state = A; // Transition to A if in = 0
            end // stays in B if in = 1
        end
        A: begin
            if (in == 1'b1) begin
                next_state = A; // Remain in A if in = 1
            end else begin
                next_state = B; // Transition to B if in = 0
            end
        end
        default: begin
            next_state = B; // Fallback to state B for safety
        end
    endcase
end

endmodule
```