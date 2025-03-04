module lemming_fsm (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic {
        STATE_LEFT = 1'b0,
        STATE_RIGHT = 1'b1
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_LEFT: begin
                if (bump_left) begin
                    next_state = STATE_RIGHT;
                end else begin
                    next_state = STATE_LEFT;
                end
            end
            STATE_RIGHT: begin
                if (bump_right) begin
                    next_state = STATE_LEFT;
                end else begin
                    next_state = STATE_RIGHT;
                end
            end
            default: begin
                next_state = STATE_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            STATE_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            STATE_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule