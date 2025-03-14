[BEGIN]
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

    // State encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALL_LEFT = 3'b010,
        FALL_RIGHT = 3'b011,
        DIG_LEFT = 3'b100,
        DIG_RIGHT = 3'b101,
        SPLATTERED = 3'b110
    } state_t;

    state_t state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            state <= next_state;
            if (state == FALL_LEFT || state == FALL_RIGHT)
                fall_counter <= fall_counter + 5'd1;
            else
                fall_counter <= 5'd0;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        next_state = state; // Default to remain in the same state

        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground)
                    next_state = FALL_LEFT;
                else if (dig)
                    next_state = DIG_LEFT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground)
                    next_state = FALL_RIGHT;
                else if (dig)
                    next_state = DIG_RIGHT;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end

            FALL_LEFT, FALL_RIGHT: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTERED;
                    else if (state == FALL_LEFT)
                        next_state = WALK_LEFT;
                    else
                        next_state = WALK_RIGHT;
                end
            end

            DIG_LEFT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = FALL_LEFT;
            end

            DIG_RIGHT: begin
                digging = 1'b1;
                if (!ground)
                    next_state = FALL_RIGHT;
            end

            SPLATTERED: begin
                // All outputs remain 0
            end

            default: next_state = WALK_LEFT;
        endcase
    end

endmodule
[DONE]