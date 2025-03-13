[BEGIN]
module TopModule (
    input logic clk,            // Clock signal (1-bit)
    input logic areset,        // Active-high asynchronous reset (1-bit)
    input logic j,             // Input signal j for state transitions (1-bit)
    input logic k,             // Input signal k for state transitions (1-bit)
    output logic out           // Output signal (1-bit)
);

// State Definitions
typedef enum logic [1:0] {
    OFF = 2'b00,             // State OFF: out = 0
    ON = 2'b01               // State ON: out = 1
} state_t;

state_t current_state, next_state;

// Initial State
initial begin
    current_state = OFF;     // Default initial state for simulation
    out = 1'b0;              // Default output state
end

// Synchronous Reset Behavior
always @ (posedge clk) begin
    if (areset) begin
        current_state <= OFF; // Reset state to OFF
        out <= 1'b0;          // Reset output to 0
    end else begin
        current_state <= next_state; // Update state on clock edge
    end
end

// Next State Logic
always @ (*) begin
    case (current_state)
        OFF: begin
            out = 1'b0; // Output is 0 in OFF state
            if (j) begin
                next_state = ON; // Transition to ON if j = 1
            end else begin
                next_state = OFF; // Remain in OFF if j = 0
            end
        end
        ON: begin
            out = 1'b1; // Output is 1 in ON state
            if (k) begin
                next_state = OFF; // Transition to OFF if k = 1
            end else begin
                next_state = ON; // Remain in ON if k = 0
            end
        end
        default: begin
            next_state = OFF; // Default case to prevent latches
        end
    endcase
end

endmodule
[DONE]