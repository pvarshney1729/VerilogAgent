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

    // State definitions
    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALL,
        STATE_DIG,
        STATE_SPLAT
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5 bits to count up to 20
    logic falling;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 0;
            falling <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALL) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 0;
            end
        end
    end

    // Combinational logic for next state and output generation
    always @(*) begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        next_state = current_state; // Default next state

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1;
                if (bump_right) next_state = STATE_WALK_RIGHT;
                else if (!ground) next_state = STATE_FALL;
                else if (dig) next_state = STATE_DIG;
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1;
                if (bump_left) next_state = STATE_WALK_LEFT;
                else if (!ground) next_state = STATE_FALL;
                else if (dig) next_state = STATE_DIG;
            end

            STATE_FALL: begin
                aaah = 1;
                falling = 1;
                if (ground) begin
                    if (fall_counter > 20) next_state = STATE_SPLAT;
                    else if (current_state == STATE_WALK_LEFT) next_state = STATE_WALK_LEFT;
                    else if (current_state == STATE_WALK_RIGHT) next_state = STATE_WALK_RIGHT;
                end
            end

            STATE_DIG: begin
                digging = 1;
                if (!ground) next_state = STATE_FALL;
            end

            STATE_SPLAT: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
                next_state = STATE_SPLAT; // Remain in splat state
            end
            
            default: next_state = STATE_WALK_LEFT; // Safety default
        endcase
    end

endmodule