module TopModule (
    input logic clk,              // Clock input
    input logic areset,           // Asynchronous reset, active high
    input logic bump_left,        // Bump from the left
    input logic bump_right,       // Bump from the right
    input logic ground,           // Ground presence signal
    output logic walk_left,       // Walking left output
    output logic walk_right,      // Walking right output
    output logic aaah             // Falling output
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;
    state_t previous_state; // To remember the last walking direction

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            previous_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
            if (ground) begin
                previous_state <= next_state;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                if (ground) begin
                    next_state = previous_state;
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
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
    end

endmodule