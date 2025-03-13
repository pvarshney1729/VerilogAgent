[BEGIN]
module TopModule (
    input  logic clk,            // Clock signal (positive edge-triggered)
    input  logic areset,        // Asynchronous active-high reset signal
    input  logic in,            // Single-bit input signal to the FSM
    output logic out             // Single-bit output signal from the FSM
);

// State encoding
typedef enum logic [1:0] {
    A = 2'b00,  // State A
    B = 2'b01,  // State B
    C = 2'b10,  // State C
    D = 2'b11   // State D
} state_t;

// State declaration
state_t current_state, next_state;

// Synchronous reset and state transition logic
always_ff @(posedge clk) begin
    if (areset) begin
        current_state <= A;   // Reset to state A
        out <= 1'b0;          // Reset output to 0
    end else begin
        current_state <= next_state; // Transition to next state
    end
end

// Next state logic based on current state and input
always_comb begin
    next_state = current_state; // Default to hold current state
    out = 1'b0;                  // Default output

    case (current_state)
        A: begin
            if (in) next_state = B;  // Transition from A to B on input 1
        end
        B: begin
            if (in) next_state = B;  // Stay in B on input 1
            else next_state = C;     // Transition from B to C on input 0
        end
        C: begin
            if (in) next_state = D;  // Transition from C to D on input 1
            else next_state = A;     // Transition from C to A on input 0
        end
        D: begin
            if (in) next_state = B;  // Transition from D to B on input 1
            else next_state = C;     // Transition from D to C on input 0
            out = 1'b1;              // Output is 1 in state D
        end
        default: begin
            next_state = A;          // Default case for safety
        end
    endcase
end

endmodule
[DONE]