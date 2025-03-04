module TopModule (
    input logic clk,        // Clock signal, positive edge-triggered
    input logic areset,     // Asynchronous reset, active high
    input logic bump_left,  // Bump detected on the left side
    input logic bump_right, // Bump detected on the right side
    input logic ground,     // Ground detection (1 = on ground, 0 = falling)
    input logic dig,        // Command to start digging
    output logic walk_left, // Output high when walking left
    output logic walk_right,// Output high when walking right
    output logic aaah,      // Output high when falling (ahh!)
    output logic digging    // Output high when digging
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // 5-bit counter for falling cycles

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == FALLING)
                fall_counter <= fall_counter + 1;
            else
                fall_counter <= 5'd0;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            WALK_LEFT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING;
                else if (bump_left)
                    next_state = WALK_RIGHT;
            end
            WALK_RIGHT: begin
                if (!ground)
                    next_state = FALLING;
                else if (dig)
                    next_state = DIGGING;
                else if (bump_right)
                    next_state = WALK_LEFT;
            end
            FALLING: begin
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = SPLATTERED;
                    else
                        next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
                end
            end
            DIGGING: begin
                if (!ground)
                    next_state = FALLING;
                else if (!dig)
                    next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
            end
            SPLATTERED: begin
                // Remain in SPLATTERED state
            end
        endcase
    end

    // Output logic
    always_comb begin
        walk_left = (current_state == WALK_LEFT);
        walk_right = (current_state == WALK_RIGHT);
        aaah = (current_state == FALLING);
        digging = (current_state == DIGGING);
    end

endmodule