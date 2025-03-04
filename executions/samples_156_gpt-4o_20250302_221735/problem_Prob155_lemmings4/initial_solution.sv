module lemming_fsm (
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
        IDLE = 3'b000,
        WALK_LEFT = 3'b001,
        WALK_RIGHT = 3'b010,
        FALL = 3'b011,
        DIG = 3'b100,
        SPLATTER = 3'b101
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            fall_counter <= 5'b00000;
        end else begin
            current_state <= next_state;
            if (current_state == FALL) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'b00000;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL;
                end else if (dig) begin
                    next_state = DIG;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL: begin
                if (ground) begin
                    if (fall_counter >= 5'd20) begin
                        next_state = SPLATTER;
                    end else begin
                        next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
                    end
                end else if (fall_counter >= 5'd20) begin
                    next_state = SPLATTER;
                end else begin
                    next_state = FALL;
                end
            end
            DIG: begin
                if (!ground) begin
                    next_state = FALL;
                end else begin
                    next_state = DIG;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALL);
        digging = (current_state == DIG);
    end

endmodule