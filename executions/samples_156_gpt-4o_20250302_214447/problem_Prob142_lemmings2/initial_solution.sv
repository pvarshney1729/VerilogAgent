module TopModule (
    input logic clk_i,
    input logic areset_i,
    input logic bump_left_i,
    input logic bump_right_i,
    input logic ground_i,
    output logic walk_left_o,
    output logic walk_right_o,
    output logic aaah_o
);

    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING    = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t last_walk_state;

    // State transition logic
    always_ff @(posedge clk_i or posedge areset_i) begin
        if (areset_i) begin
            current_state <= WALK_LEFT;
            last_walk_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (next_state == WALK_LEFT || next_state == WALK_RIGHT) begin
                last_walk_state <= next_state;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground_i) begin
                    next_state = FALLING;
                end else if (bump_left_i) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground_i) begin
                    next_state = FALLING;
                end else if (bump_right_i) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground_i) begin
                    next_state = last_walk_state;
                end else begin
                    next_state = FALLING;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left_o = (current_state == WALK_LEFT);
        walk_right_o = (current_state == WALK_RIGHT);
        aaah_o = (current_state == FALLING);
    end

endmodule