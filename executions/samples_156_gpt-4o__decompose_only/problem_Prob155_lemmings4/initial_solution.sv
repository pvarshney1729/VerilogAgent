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
    typedef enum logic [2:0] {
        WALK_LEFT  = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT  = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT   = 3'b100,
        DIG_RIGHT  = 3'b101,
        SPLATTER   = 3'b110
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter; // 5-bit counter to count up to 20

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT) begin
                fall_counter <= fall_counter + 1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else if (dig) begin
                    next_state = DIG_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else if (dig) begin
                    next_state = DIG_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALL_LEFT, FALL_RIGHT: begin
                if (ground) begin
                    if (fall_counter > 5'd20) begin
                        next_state = SPLATTER;
                    end else if (state == FALL_LEFT) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = state;
                end
            end
            DIG_LEFT: begin
                if (!ground) begin
                    next_state = FALL_LEFT;
                end else begin
                    next_state = DIG_LEFT;
                end
            end
            DIG_RIGHT: begin
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end else begin
                    next_state = DIG_RIGHT;
                end
            end
            SPLATTER: begin
                next_state = SPLATTER;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (state == WALK_LEFT);
        walk_right = (state == WALK_RIGHT);
        aaah = (state == FALL_LEFT || state == FALL_RIGHT);
        digging = (state == DIG_LEFT || state == DIG_RIGHT);
    end

endmodule