[BEGIN]
module TopModule (
    input logic clk,         // Clock signal 
    input logic reset,       // Active high synchronous reset
    input logic s,           // Input signal for state A (1 bit)
    input logic w,           // Input signal for state B (1 bit)
    output logic z           // Output signal (1 bit)
);

// State declaration
typedef enum logic [1:0] {
    A = 2'b00,             // State A
    B = 2'b01              // State B
} state_t;

state_t current_state, next_state;
logic [2:0] w_count;      // 3-bit register to count w = 1 occurrences in the last three cycles
logic [1:0] cycle_counter; // 2-bit register to count the cycles (0, 1, 2)

// Synchronize the reset and state transition on the positive edge of clk
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= A; // Reset state is A
        z <= 1'b0;          // Output z initialized to 0
        w_count <= 3'b000;  // Initialize w_count
        cycle_counter <= 2'b00; // Initialize cycle_counter
    end else begin
        current_state <= next_state;
    end
end

// FSM state transition logic
always_ff @(posedge clk) begin
    case (current_state)
        A: begin
            if (s) begin
                next_state <= B; // Transition to state B on s = 1
            end else begin
                next_state <= A; // Remain in state A if s = 0
            end
            z <= 1'b0; // Set output z to 0 while in state A
        end
        B: begin
            // Shift the count and include the current w value
            w_count <= {w_count[1:0], w}; // Shift the previous counts and add new w value
            if (cycle_counter < 2'b10) begin
                cycle_counter <= cycle_counter + 1; // Increment cycle counter
            end else begin
                // After 3 cycles, check the count
                if (w_count[2] + w_count[1] + w_count[0] == 3'b010) begin
                    z <= 1'b1; // Set z to 1 if exactly two of the last three w values were 1
                end else begin
                    z <= 1'b0; // Otherwise, set z to 0
                end
                // Reset counters for the next set of cycles
                w_count <= 3'b000;
                cycle_counter <= 2'b00;
            end
        end
        default: begin
            next_state <= A; // Default to state A
            z <= 1'b0;       // Default output
        end
    endcase
end

endmodule
[DONE]