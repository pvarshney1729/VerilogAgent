module TopModule (
    input  logic clk,        // Clock signal, positive edge-triggered
    input  logic areset,     // Asynchronous reset, active high
    input  logic bump_left,  // Bump signal from the left
    input  logic bump_right, // Bump signal from the right
    input  logic ground,     // Ground presence indicator
    input  logic dig,        // Dig command
    output logic walk_left,  // Lemming is walking left
    output logic walk_right, // Lemming is walking right
    output logic aaah,       // Lemming is falling
    output logic digging     // Lemming is digging
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        DIGGING,
        FALLING,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5-bit counter to track falling cycles

    // State transition logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig && ground)
                    next_state = DIGGING;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig && ground)
                    next_state = DIGGING;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            DIGGING: begin
                if (!ground)
                    next_state = FALLING;
            end
            FALLING: begin
                if (ground && fall_counter > 5'd20)
                    next_state = SPLATTERED;
                else if (ground)
                    next_state = WALK_LEFT;
            end
            SPLATTERED: begin
                // Remain in SPLATTERED state until reset
            end
        endcase
    end

    // Output logic
    always @(*) begin
        walk_left = 0;
        walk_right = 0;
        aaah = 0;
        digging = 0;
        case (current_state)
            WALK_LEFT: walk_left = 1;
            WALK_RIGHT: walk_right = 1;
            DIGGING: digging = 1;
            FALLING: aaah = 1;
            SPLATTERED: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            end
        endcase
    end

    // State and counter update logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 0;
        end
    end

endmodule