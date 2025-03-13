[BEGIN]
module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b01,
        STATE_WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset logic
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_left && bump_right) begin
                    next_state = STATE_WALK_RIGHT; // Toggle state
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_left && bump_right) begin
                    next_state = STATE_WALK_LEFT; // Toggle state
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            default: next_state = STATE_WALK_LEFT; // Default to avoid latches
        endcase
    end

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);

endmodule
[DONE]