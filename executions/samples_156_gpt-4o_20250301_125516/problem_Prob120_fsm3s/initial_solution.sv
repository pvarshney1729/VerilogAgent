module TopModule (
    input logic clk,      // Clock signal, positive edge-triggered
    input logic reset,    // Synchronous active high reset
    input logic in,       // Input signal for state transitions
    output logic out      // Output signal, determined by current state
);

    typedef enum logic [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_A: next_state = (in) ? STATE_B : STATE_A;
            STATE_B: next_state = (in) ? STATE_B : STATE_C;
            STATE_C: next_state = (in) ? STATE_D : STATE_A;
            STATE_D: next_state = (in) ? STATE_B : STATE_C;
            default: next_state = STATE_A; // Default case for safety
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_D: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

endmodule