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
        
        // State transitions
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                    walk_left = 1'b1;
                end
            end
            
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                    walk_right = 1'b1;
                end
            end
            
            STATE_FALL: begin
                if (ground) begin
                    if (bump_left) begin
                        next_state = STATE_WALK_RIGHT;
                    end else if (bump_right) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = current_state; // Stay falling
                    end
                end else begin
                    next_state = STATE_FALL; // Continue falling
                    aaah = 1'b1;
                end
            end
            
            STATE_DIG: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else begin
                    next_state = STATE_DIG; // Continue digging
                    digging = 1'b1;
                end
            end
            
            default: begin
                next_state = STATE_WALK_LEFT; // Default state
            end
        endcase
    end

endmodule