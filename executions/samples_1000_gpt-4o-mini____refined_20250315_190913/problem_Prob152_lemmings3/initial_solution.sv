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
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIG
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = current_state;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                    end else if (current_state == STATE_WALK_RIGHT) begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
            end

            STATE_DIG: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (ground) begin
                    next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                end
            end
        endcase
    end
endmodule