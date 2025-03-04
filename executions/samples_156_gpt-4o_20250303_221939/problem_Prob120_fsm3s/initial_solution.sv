```verilog
module TopModule (
    input logic clk,          // Clock signal: Positive edge-triggered
    input logic reset,        // Synchronous active high reset
    input logic in,           // Single-bit input signal
    output logic out          // Single-bit output signal
);

    // State encoding using a 2-bit register
    typedef enum logic [1:0] {
        STATE_A = 2'b00,    // Initial state after reset
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;
    
    // Current state register
    state_t current_state, next_state;

    // Synchronous state transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;  // Reset state
            out <= 1'b0;               // Reset output
        end else begin
            current_state <= next_state; // Transition to the next state
            case (next_state)
                STATE_D: out <= 1'b1;  // Output logic for state D
                default: out <= 1'b0;  // Output logic for other states
            endcase
        end
    end

    // Next state logic based on current state and input
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Default transition
        endcase
    end

endmodule
```