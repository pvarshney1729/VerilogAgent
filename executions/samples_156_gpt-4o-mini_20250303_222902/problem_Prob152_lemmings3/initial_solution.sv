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
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (bump_right) begin
                    next_state = WALK_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (walk_left) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALLING;
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else begin
                    next_state = DIGGING;
                end
            end

            default: next_state = WALK_LEFT;
        endcase
    end

endmodule