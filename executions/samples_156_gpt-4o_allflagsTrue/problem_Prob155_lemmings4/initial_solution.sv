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
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTER = 3'b110
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    // State transition logic
    always @(*) begin
        // Default next state
        next_state = current_state;
        
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left || bump_right)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_left || bump_right)
                    next_state = WALK_LEFT;
            end
            FALL_LEFT: begin
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_LEFT;
                end
            end
            FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTER;
                    else
                        next_state = WALK_RIGHT;
                end
            end
            DIG_LEFT: begin
                if (!ground)
                    next_state = FALL_LEFT;
            end
            DIG_RIGHT: begin
                if (!ground)
                    next_state = FALL_RIGHT;
            end
            SPLATTER: begin
                // Remain in SPLATTER state
            end
        endcase
    end

    // Sequential logic for state and fall counter
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALL_LEFT || current_state == FALL_RIGHT)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 5'd0;
        end
    end

    // Output logic
    always @(*) begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALL_LEFT || current_state == FALL_RIGHT);
        digging = (current_state == DIG_LEFT || current_state == DIG_RIGHT);
    end

endmodule