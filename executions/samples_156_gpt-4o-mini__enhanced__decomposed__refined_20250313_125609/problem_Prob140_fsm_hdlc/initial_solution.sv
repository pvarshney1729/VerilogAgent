```verilog
[BEGIN]
module TopModule (
    input logic clk,          // Clock signal (positive edge triggered)
    input logic reset,        // Active high synchronous reset
    input logic in,          // Input data stream (1-bit, unsigned)
    output logic disc,        // Output signal to indicate a bit needs to be discarded (1-bit)
    output logic flag,        // Output signal to indicate frame boundary (1-bit)
    output logic err          // Output signal to indicate error (1-bit)
);

// State Definitions
typedef enum logic [2:0] {
    IDLE,         // Initial state, waiting for input
    SEQ1,        // Detected 0111110
    SEQ2,        // Detected 01111110 (flag)
    SEQ_ERR      // Detected 7 or more consecutive 1s
} state_t;

state_t current_state, next_state;

// Synchronous reset
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE; // Reset to IDLE state
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end else begin
        current_state <= next_state; // Transition to the next state
    end
end

// FSM Logic
always @(*) begin
    // Default outputs
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    // Next state logic and output generation
    case (current_state)
        IDLE: begin
            if (in) begin
                next_state = SEQ1;
            end else begin
                next_state = IDLE;
            end
        end

        SEQ1: begin
            if (in) begin
                next_state = SEQ2; // Move to SEQ2 on receiving the next 1
            end else begin
                next_state = IDLE; // Back to IDLE on receiving a 0
            end
        end
        
        SEQ2: begin
            if (in) begin
                next_state = SEQ_ERR; // Transition to error state on 7th 1
                err = 1'b1; // Signal error immediately
            end else begin
                disc = 1'b1; // Signal to discard the next bit
                next_state = IDLE; // Return to IDLE after flag
            end
        end
        
        SEQ_ERR: begin
            if (in) begin
                err = 1'b1; // Remain in error state
                next_state = SEQ_ERR; // Stay in error state
            end else begin
                next_state = IDLE; // Return to IDLE on receiving a 0
            end
        end
        
        default: begin
            next_state = IDLE; // Default state transition
        end
    endcase
end

// Output Behavior 
always @(posedge clk) begin
    // Outputs are asserted for one clock cycle
    if (current_state == SEQ1) begin
        disc <= 1'b1; // Assert discard on SEQ1
    end else if (current_state == SEQ2) begin
        flag <= 1'b1; // Assert flag on SEQ2
    end else if (current_state == SEQ_ERR) begin
        err <= 1'b1; // Assert error on SEQ_ERR
    end
end

endmodule
[DONE]
```