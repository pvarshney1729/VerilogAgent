module moore_fsm (
    input logic clk,
    input logic reset,
    output logic out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= B; // Reset to state B
        end else begin
            state <= next_state; // Transition to next state
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = A; // Stay in state A
            B: next_state = B; // Stay in state B
            default: next_state = A; // Default case
        endcase
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule