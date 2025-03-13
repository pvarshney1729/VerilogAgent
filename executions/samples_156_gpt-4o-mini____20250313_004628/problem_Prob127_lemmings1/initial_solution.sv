module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_right || bump_left) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (bump_left || bump_right) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_WALK_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State update logic with synchronous reset
    always @(posedge clk) begin
        if (areset) 
            current_state <= STATE_WALK_LEFT;
        else 
            current_state <= next_state;
    end

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);

endmodule