module TopModule(
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    output logic walk_left,
    output logic walk_right,
    output logic aaah
);

    typedef enum logic [1:0] {
        LEFT = 2'b00,
        RIGHT = 2'b01,
        FALLING_LEFT = 2'b10,
        FALLING_RIGHT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            LEFT: begin
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end else if (bump_left) begin
                    next_state = RIGHT;
                end else begin
                    next_state = LEFT;
                end
            end
            RIGHT: begin
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end else if (bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = RIGHT;
                end
            end
            FALLING_LEFT: begin
                if (ground) begin
                    next_state = LEFT;
                end else begin
                    next_state = FALLING_LEFT;
                end
            end
            FALLING_RIGHT: begin
                if (ground) begin
                    next_state = RIGHT;
                end else begin
                    next_state = FALLING_RIGHT;
                end
            end
            default: next_state = LEFT;
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == LEFT);
        walk_right = (current_state == RIGHT);
        aaah = (current_state == FALLING_LEFT) || (current_state == FALLING_RIGHT);
    end

endmodule