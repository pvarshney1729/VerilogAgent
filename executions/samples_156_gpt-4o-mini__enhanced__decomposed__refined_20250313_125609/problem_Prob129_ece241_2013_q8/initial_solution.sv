```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock input (1 bit)
    input logic aresetn,      // Active low asynchronous reset (1 bit)
    input logic x,            // Input signal to be analyzed (1 bit)
    output logic z            // Output signal indicating sequence detection (1 bit)
);

// Define the states of the FSM
typedef enum logic [1:0] {
    S0, // Initial state (waiting for '1')
    S1, // First '1' detected (waiting for '0')
    S2  // '10' detected (waiting for '1', output z = 1)
} state_t;

// State variable
state_t current_state, next_state;

// Synchronous reset and state transition
always @(posedge clk) begin
    if (!aresetn) begin
        current_state <= S0; // Reset to initial state
        z <= 1'b0;           // Output z is low on reset
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// FSM state logic
always @(*) begin
    // Default state assignments
    next_state = current_state; // Hold current state by default
    z = 1'b0; // Default output

    case (current_state)
        S0: begin
            if (x) begin
                next_state = S1; // Move to state S1 on input '1'
            end
        end
        S1: begin
            if (~x) begin
                next_state = S2; // Move to state S2 on input '0'
            end
        end
        S2: begin
            if (x) begin
                z = 1'b1; // Output z = 1 when '101' is detected
                next_state = S1; // Overlap allowed, move back to S1
            end else begin
                next_state = S0; // Reset to S0 on '0'
            end
        end
    endcase
end

endmodule
[DONE]
```