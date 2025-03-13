```
[BEGIN]
module TopModule (
    input  logic clk,          // Clock signal
    input  logic areset,       // Asynchronous reset, active high
    input  logic bump_left,    // Lemming is bumped on the left
    input  logic bump_right,   // Lemming is bumped on the right
    input  logic ground,       // Ground presence signal
    input  logic dig,          // Dig command
    output logic walk_left,    // Lemming walking left
    output logic walk_right,   // Lemming walking right
    output logic aaah,         // Lemming is falling
    output logic digging       // Lemming is digging
);

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIG,
        STATE_SPLATTER
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_count;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_count <= 5'b0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALL) begin
                fall_count <= fall_count + 1;
            end else begin
                fall_count <= 5'b0;
            end
        end
    end

    always_ff @(*) begin
        next_state = current_state; // Default to hold current state
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_left) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_right) begin
                    next_state = STATE_WALK_LEFT;
                end
            end

            STATE_FALL: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_count > 5'd20) begin
                        next_state = STATE_SPLATTER;
                    end else begin
                        next_state = (current_state == STATE_WALK_LEFT) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end
            end

            STATE_DIG: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = STATE_FALL;
                end
            end

            STATE_SPLATTER: begin
                // All outputs should remain 0
            end
        endcase
    end

endmodule
[DONE]
```