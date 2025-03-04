module TopModule(
    input logic clk,                // Clock signal, positive edge triggered
    input logic areset,             // Asynchronous reset, active high
    input logic bump_left,          // Obstacle detection on the left
    input logic bump_right,         // Obstacle detection on the right
    input logic ground,             // Indicates presence of ground
    input logic dig,                // Command to start digging
    output logic walk_left,         // Indicates walking left
    output logic walk_right,        // Indicates walking right
    output logic aaah,              // Indicates falling
    output logic digging            // Indicates digging
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING)
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
        next_state = current_state;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig && ground) begin
                    next_state = DIGGING;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter >= 5'd20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
                    end
                end
            end

            DIGGING: begin
                digging = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end
            end

            SPLATTERED: begin
                // Remain in splattered state
            end

            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

endmodule