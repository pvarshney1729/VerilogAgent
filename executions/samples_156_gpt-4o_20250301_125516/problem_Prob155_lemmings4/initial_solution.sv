module TopModule (
    input logic clk,             // Clock signal for synchronization.
    input logic areset,          // Asynchronous reset, active high.
    input logic bump_left,       // Indicates a bump on the left.
    input logic bump_right,      // Indicates a bump on the right.
    input logic ground,          // Indicates presence of ground.
    input logic dig,             // Command to start digging.
    output logic walk_left,      // Output high when walking left.
    output logic walk_right,     // Output high when walking right.
    output logic aaah,           // Output high when falling.
    output logic digging         // Output high when digging.
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING_LEFT,
        FALLING_RIGHT,
        DIGGING_LEFT,
        DIGGING_RIGHT,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING_LEFT || current_state == FALLING_RIGHT) begin
                fall_counter <= fall_counter + 5'd1;
            end else begin
                fall_counter <= 5'd0;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING_LEFT;
                end else if (dig) begin
                    next_state = DIGGING_LEFT;
                end else if (bump_left) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING_RIGHT;
                end else if (dig) begin
                    next_state = DIGGING_RIGHT;
                end else if (bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end
            FALLING_LEFT, FALLING_RIGHT: begin
                if (ground && fall_counter > 5'd20) begin
                    next_state = SPLATTERED;
                end else if (ground) begin
                    next_state = (current_state == FALLING_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end else begin
                    next_state = current_state;
                end
            end
            DIGGING_LEFT, DIGGING_RIGHT: begin
                if (!ground) begin
                    next_state = (current_state == DIGGING_LEFT) ? FALLING_LEFT : FALLING_RIGHT;
                end else begin
                    next_state = current_state;
                end
            end
            SPLATTERED: begin
                next_state = SPLATTERED;
            end
            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;
        case (current_state)
            WALK_LEFT: walk_left = 1'b1;
            WALK_RIGHT: walk_right = 1'b1;
            FALLING_LEFT, FALLING_RIGHT: aaah = 1'b1;
            DIGGING_LEFT, DIGGING_RIGHT: digging = 1'b1;
            SPLATTERED: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
                digging = 1'b0;
            end
        endcase
    end

endmodule