[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    // State Encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    // State Registers
    state_t current_state, next_state;

    // State Transition Logic with Synchronous Reset
    always_ff @(posedge clk) begin
        if (areset)
            current_state <= WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (bump_left || (bump_left && bump_right))
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right || (bump_left && bump_right))
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
        endcase
    end

    // Output Logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT) ? 1'b1 : 1'b0;
        walk_right = (current_state == WALK_RIGHT) ? 1'b1 : 1'b0;
    end

endmodule
[DONE]