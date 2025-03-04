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
        STATE_WALK_LEFT = 3'b000,
        STATE_WALK_RIGHT = 3'b001,
        STATE_FALLING = 3'b010,
        STATE_DIGGING_LEFT = 3'b011,
        STATE_DIGGING_RIGHT = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        next_state = current_state; // Default to hold state
        case (current_state)
            STATE_WALK_LEFT: begin
                if (ground == 0) begin
                    next_state = STATE_FALLING;
                end else if (dig == 1) begin
                    next_state = STATE_DIGGING_LEFT;
                end else if (bump_left == 1) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (ground == 0) begin
                    next_state = STATE_FALLING;
                end else if (dig == 1) begin
                    next_state = STATE_DIGGING_RIGHT;
                end else if (bump_right == 1) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_FALLING: begin
                if (ground == 1) begin
                    next_state = (bump_left == 1) ? STATE_WALK_RIGHT : 
                                 (bump_right == 1) ? STATE_WALK_LEFT : 
                                 current_state; // Stay in falling if no bumps
                end
            end
            STATE_DIGGING_LEFT: begin
                if (ground == 0) begin
                    next_state = STATE_FALLING;
                end
            end
            STATE_DIGGING_RIGHT: begin
                if (ground == 0) begin
                    next_state = STATE_FALLING;
                end
            end
        endcase
    end

    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);
    assign aaah = (current_state == STATE_FALLING);
    assign digging = (current_state == STATE_DIGGING_LEFT || current_state == STATE_DIGGING_RIGHT);

endmodule