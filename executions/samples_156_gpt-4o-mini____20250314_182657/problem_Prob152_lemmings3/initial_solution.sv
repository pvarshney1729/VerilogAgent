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

    typedef enum logic [1:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end
            end
            FALLING: begin
                if (ground) begin
                    if (current_state == FALLING) begin
                        next_state = (bump_left) ? WALK_LEFT : WALK_RIGHT;
                    end
                end
            end
            DIGGING: begin
                if (!ground) begin
                    next_state = FALLING;
                end
            end
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (current_state == WALK_LEFT);
    assign walk_right = (current_state == WALK_RIGHT);
    assign aaah = (current_state == FALLING);
    assign digging = (current_state == DIGGING);

endmodule