[BEGIN]
module TopModule (
    input logic clk,       // Clock signal
    input logic reset,     // Synchronous active-high reset
    input logic w,         // Input signal for state transitions
    output logic z         // Output signal reflecting FSM state
);

    // State Encoding
    typedef enum logic [2:0] {
        STATE_A = 3'b000,
        STATE_B = 3'b001,
        STATE_C = 3'b010,
        STATE_D = 3'b011,
        STATE_E = 3'b100,
        STATE_F = 3'b101
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
    always @(*) begin
        case (current_state)
            STATE_A: next_state = (w) ? STATE_B : STATE_A;
            STATE_B: next_state = (w) ? STATE_C : STATE_D;
            STATE_C: next_state = (w) ? STATE_E : STATE_D;
            STATE_D: next_state = (w) ? STATE_F : STATE_A;
            STATE_E: next_state = (w) ? STATE_E : STATE_D;
            STATE_F: next_state = (w) ? STATE_C : STATE_D;
            default: next_state = STATE_A; // Default case for safety
        endcase
    end

    // Output logic for z based on the current state
    always @(*) begin
        case (current_state)
            STATE_E, STATE_F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
[DONE]