module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic bump_left,
    input  logic bump_right,
    input  logic ground,
    input  logic dig,
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
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 5'b00000;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'b00000;
            end
        end
    end

    always_comb begin
        next_state = current_state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end else if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                } else if (dig) begin
                    next_state = STATE_DIG;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end else if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end
            end

            STATE_FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'b10100) begin
                        next_state = STATE_SPLAT;
                    end else begin
                        next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end
            end

            STATE_DIG: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end
            end

            STATE_SPLAT: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end
endmodule