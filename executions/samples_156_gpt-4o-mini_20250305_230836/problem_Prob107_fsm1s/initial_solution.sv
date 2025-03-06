module TopModule (
    input logic clk,      // Clock signal, assumed to be a single bit
    input logic reset,    // Synchronous active-high reset signal, single bit
    input logic in,       // One-bit input signal
    output logic out      // One-bit output signal
);

// State encoding
typedef enum logic [1:0] {
    STATE_A = 2'b00,     // State A, output is 0
    STATE_B = 2'b01      // State B, output is 1
} state_t;

state_t current_state, next_state;

// Initial state and reset behavior
initial begin
    current_state = STATE_B; // Define initial state as B
    out = 1'b1;              // Initial output corresponding to state B
end

// State transition logic
always_ff @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_B; // Reset state is B
        out <= 1'b1;              // Output corresponding to reset state B
    end else begin
        current_state <= next_state; // Transition to next state
    end
end

// Next state logic and output logic
always_comb begin
    case (current_state)
        STATE_A: begin
            out = 1'b0; // Output for state A
            if (in == 1'b0) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            out = 1'b1; // Output for state B
            if (in == 1'b0) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_B; // Default to state B to handle invalid states
            out = 1'b1;           // Default output for invalid states
        end
    endcase
end

endmodule