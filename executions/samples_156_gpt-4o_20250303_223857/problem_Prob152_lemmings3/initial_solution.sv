module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic areset,       // Asynchronous reset, active-high
    input logic bump_left,    // Left side bump indicator
    input logic bump_right,   // Right side bump indicator
    input logic ground,       // Ground presence indicator
    input logic dig,          // Dig command
    output logic walk_left,   // Lemming walking left indicator
    output logic walk_right,  // Lemming walking right indicator
    output logic aaah,        // Lemming falling indicator
    output logic digging      // Lemming digging indicator
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;
    logic last_walk_direction; // 0 for left, 1 for right

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            last_walk_direction <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == WALK_LEFT || current_state == WALK_RIGHT) begin
                last_walk_direction <= (current_state == WALK_RIGHT);
            end
        end
    end

    always_comb begin
        // Default output values
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    next_state = last_walk_direction ? WALK_RIGHT : WALK_LEFT;
                end else begin
                    next_state = FALLING;
                end
            end
            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = DIGGING;
                end
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule