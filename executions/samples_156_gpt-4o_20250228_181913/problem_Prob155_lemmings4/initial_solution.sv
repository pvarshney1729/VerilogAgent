module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING,
        STATE_DIGGING,
        STATE_SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALLING && ground == 0)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 5'd0;
        end
    end

    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (ground == 0)
                    next_state = STATE_FALLING;
                else if (dig == 1)
                    next_state = STATE_DIGGING;
                else if (bump_left == 1)
                    next_state = STATE_WALK_RIGHT;
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (ground == 0)
                    next_state = STATE_FALLING;
                else if (dig == 1)
                    next_state = STATE_DIGGING;
                else if (bump_right == 1)
                    next_state = STATE_WALK_LEFT;
            end

            STATE_FALLING: begin
                aaah = 1'b1;
                if (ground == 1) begin
                    if (fall_counter > 5'd20)
                        next_state = STATE_SPLATTERED;
                    else if (walk_left == 1)
                        next_state = STATE_WALK_LEFT;
                    else
                        next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_DIGGING: begin
                digging = 1'b1;
                if (ground == 0)
                    next_state = STATE_FALLING;
            end

            STATE_SPLATTERED: begin
                // Remain in splattered state
            end
        endcase
    end

endmodule