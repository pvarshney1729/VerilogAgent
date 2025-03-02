module TopModule (
    input logic clk,
    input logic reset,
    input logic bump_left,
    input logic bump_right,
    output logic walk_left,
    output logic walk_right
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WALK_LEFT = 2'b01,
        WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = IDLE;
            end
            WALK_LEFT: begin
                if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
    end

endmodule