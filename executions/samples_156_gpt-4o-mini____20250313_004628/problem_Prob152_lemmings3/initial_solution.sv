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

    // State transition logic
    always @(*) begin
        next_state = current_state;
        aaah = 1'b0;
        digging = 1'b0;
        
        case (current_state)
            STATE_WALK_LEFT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_right) begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            
            STATE_WALK_RIGHT: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = STATE_DIG;
                end else if (bump_left) begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            
            STATE_FALL: begin
                if (ground) begin
                    if (current_state == STATE_WALK_LEFT) begin
                        next_state = STATE_WALK_LEFT;
                    end else begin
                        next_state = STATE_WALK_RIGHT;
                    end
                end
            end
            
            STATE_DIG: begin
                if (!ground) begin
                    next_state = STATE_FALL;
                    aaah = 1'b1;
                end
            end
            
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    assign walk_left = (current_state == STATE_WALK_LEFT);
    assign walk_right = (current_state == STATE_WALK_RIGHT);
    
    // Digging output
    assign digging = (current_state == STATE_DIG);

endmodule