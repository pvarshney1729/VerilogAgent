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

    // State encoding
    typedef enum logic [1:0] {
        STATE_WALK_LEFT = 2'b00,
        STATE_WALK_RIGHT = 2'b01,
        STATE_FALL = 2'b10,
        STATE_DIG = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT; // Reset to walk left
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state determination
    always_comb begin
        // Default outputs
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
                end else begin
                    next_state = STATE_WALK_LEFT;
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
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            
            STATE_FALL: begin
                aaah = 1;
                if (ground) begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = (walk_left) ? STATE_WALK_LEFT : STATE_WALK_RIGHT;
                    end
                end else begin
                    next_state = STATE_FALL;
                end
            end
            
            STATE_DIG: begin
                digging = 1;
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1;
                end else begin
                    next_state = STATE_DIG;
                end
            end
            
            default: next_state = STATE_WALK_LEFT; // Fallback state
        endcase
    end
endmodule