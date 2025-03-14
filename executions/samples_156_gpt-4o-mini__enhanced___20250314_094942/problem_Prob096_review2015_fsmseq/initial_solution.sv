module TopModule (
    input logic clk,               // Clock signal, active high
    input logic reset,             // Reset signal, active high synchronous
    input logic data,              // One-bit input data stream
    output logic start_shifting     // Output signal to indicate sequence found
);

    // State definitions for FSM
    typedef enum logic [2:0] {
        IDLE,   // Waiting for sequence
        S1,     // First bit of sequence detected (1)
        S11,    // Second bit of sequence detected (1)
        S110,   // Third bit of sequence detected (0)
        S1101   // Fourth bit of sequence detected (1)
    } state_t;

    state_t current_state, next_state;

    // Initial state of the FSM
    initial begin
        current_state = IDLE;      // FSM starts in IDLE state
        start_shifting = 0;        // Output starts low
    end

    // Synchronous reset and state transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE; // Reset state to IDLE
            start_shifting <= 0;    // Reset output
        end else begin
            current_state <= next_state; // Update state
        end
    end

    // FSM Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (data) next_state = S1;  // Transition to S1 if data is 1
                else next_state = IDLE;     // Stay in IDLE if data is 0
            end
            S1: begin
                if (data) next_state = S11; // Transition to S11 if data is 1
                else next_state = IDLE;     // Reset to IDLE if data is 0
            end
            S11: begin
                if (!data) next_state = S110; // Transition to S110 if data is 0
                else next_state = S11;      // Stay in S11 if data is 1
            end
            S110: begin
                if (data) next_state = S1101; // Transition to S1101 if data is 1
                else next_state = IDLE;     // Reset to IDLE if data is 0
            end
            S1101: begin
                next_state = S1101;         // Stay in S1101 after sequence found
            end
            default: begin
                next_state = IDLE;          // Default case to prevent latches
            end
        endcase
    end

    // Ensure start_shifting remains low until sequence is found
    always @(posedge clk) begin
        if (reset) 
            start_shifting <= 0;          // Reset output
        else if (current_state == S1101) 
            start_shifting <= 1;          // Set output when sequence is found
    end

endmodule