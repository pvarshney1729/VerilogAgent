module state_machine (
    input logic clk,
    input logic reset,
    input logic bump_left,
    input logic bump_right,
    input logic ground_detect,
    output logic [1:0] state
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        MOVE_FORWARD = 2'b01,
        TURN_LEFT = 2'b10,
        TURN_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (ground_detect)
                    next_state = MOVE_FORWARD;
                else
                    next_state = IDLE;
            end
            MOVE_FORWARD: begin
                if (bump_left)
                    next_state = TURN_RIGHT;
                else if (bump_right)
                    next_state = TURN_LEFT;
                else if (!ground_detect)
                    next_state = IDLE;
                else
                    next_state = MOVE_FORWARD;
            end
            TURN_LEFT: begin
                if (!ground_detect)
                    next_state = IDLE;
                else
                    next_state = MOVE_FORWARD;
            end
            TURN_RIGHT: begin
                if (!ground_detect)
                    next_state = IDLE;
                else
                    next_state = MOVE_FORWARD;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register with synchronous reset
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Output logic
    assign state = current_state;

endmodule