module TopModule(
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
        WALK_LEFT,
        WALK_RIGHT,
        FALL_LEFT,
        FALL_RIGHT,
        DIG_LEFT,
        DIG_RIGHT,
        SPLATTER
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_count; // 5 bits to count up to 21

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL_LEFT || current_state == FALL_RIGHT) begin
                fall_count <= fall_count + 5'd1;
            end else begin
                fall_count <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_count > 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end else begin
                    next_state = FALL_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_count > 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALL_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALL_LEFT || current_state == FALL_RIGHT);
        digging = (current_state == DIG_LEFT || current_state == DIG_RIGHT);
    end

endmodule