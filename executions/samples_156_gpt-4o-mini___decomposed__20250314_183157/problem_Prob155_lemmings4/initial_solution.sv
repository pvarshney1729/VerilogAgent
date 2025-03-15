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
        STATE_FALL,
        STATE_DIG,
        STATE_SPLAT
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5 bits to count up to 20

    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL: begin
                aaah = 1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = STATE_SPLAT;
                    end else begin
                        next_state = (walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT);
                    end
                end
            end

            STATE_DIG: begin
                digging = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;
                end else if (ground) begin
                    next_state = (walk_left ? STATE_WALK_LEFT : STATE_WALK_RIGHT);
                end
            end

            STATE_SPLAT: begin
                // All outputs are 0 in this state
            end
        endcase
    end
endmodule