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
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;
    logic last_direction; // 0 for left, 1 for right

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
            last_direction <= 1'b0;
        end else begin
            state <= next_state;
            if (state == FALLING) begin
                fall_counter <= ground ? 5'd0 : fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;

        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                    last_direction = 1'b1;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                    last_direction = 1'b0;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTERED;
                    end else if (last_direction == 1'b0) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end
            end

            SPLATTERED: begin
                // Remain in SPLATTERED state until reset
            end

            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule