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
        WALK_LEFT,
        WALK_RIGHT,
        FALLING_LEFT,
        FALLING_RIGHT,
        DIGGING_LEFT,
        DIGGING_RIGHT,
        SPLATTERED
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALLING_LEFT || state == FALLING_RIGHT) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state;

        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end else if (dig) begin
                    next_state = DIGGING_LEFT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end else if (dig) begin
                    next_state = DIGGING_RIGHT;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING_LEFT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = WALK_LEFT;
                    end
                end
            end

            FALLING_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end
            end

            DIGGING_LEFT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end
            end

            DIGGING_RIGHT: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end
            end

            SPLATTERED: begin
                // Remain in SPLATTERED state
            end

            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule