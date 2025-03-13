```verilog
[BEGIN]
module TopModule (
    input logic clk,           // Clock signal (positive edge triggered)
    input logic resetn,       // Active-low synchronous reset
    input logic [2:0] r,      // 3-bit input representing requests from devices 0, 1, and 2
    output logic [2:0] g       // 3-bit output representing grants to devices 0, 1, and 2
);

// State Definitions
typedef enum logic [1:0] {
    A = 2'b00,  // State A
    B = 2'b01,  // State B
    C = 2'b10   // State C
} state_t;

state_t current_state, next_state;

// Synchronous Reset Behavior
always @(posedge clk) begin
    if (!resetn) begin
        current_state <= A; // Reset state to A
        g <= 3'b000;        // Reset all grant outputs to 0
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// FSM State Transition Logic
always @(*) begin
    next_state = current_state; // Default to current state
    case (current_state)
        A: begin
            if (r[0]) next_state = B; // Move to state B if device 0 requests
            else if (r[1]) next_state = C; // Move to state C if device 1 requests
        end
        B: begin
            if (!r[0]) next_state = A; // Return to state A if device 0 does not request
        end
        C: begin
            if (!r[1]) next_state = A; // Return to state A if device 1 does not request
        end
        default: begin
            next_state = A; // Default state if an unexpected state occurs
        end
    endcase
end

// Output Logic for grants
always @(*) begin
    g = 3'b000; // Default to no grants
    case (current_state)
        B: g[0] = 1'b1; // Grant to device 0
        C: g[1] = 1'b1; // Grant to device 1
    endcase
end

endmodule
[DONE]
```