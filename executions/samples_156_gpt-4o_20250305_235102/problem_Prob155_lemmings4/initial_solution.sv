module TopModule (
    input logic clk,         // Clock input, triggers sequential logic on the positive edge
    input logic areset,      // Asynchronous reset, active high
    input logic bump_left,   // Input signal for left bump detection
    input logic bump_right,  // Input signal for right bump detection
    input logic ground,      // Ground detection signal, 1 when on ground
    input logic dig,         // Input signal to initiate digging

    output logic walk_left,  // Output signal, 1 when walking left
    output logic walk_right, // Output signal, 1 when walking right
    output logic aaah,       // Output signal, 1 when falling
    output logic digging     // Output signal, 1 when digging
);

    typedef enum logic [2:0] {
        STATE_WALK_LEFT,
        STATE_WALK_RIGHT,
        STATE_FALLING,
        STATE_DIGGING,
        STATE_SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
            fall_counter <= 5'd0;
        end else begin
            current_state <= next_state;
            if (current_state == STATE_FALLING)
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

        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                if (!ground)
                    next_state = STATE_FALLING;
                else if (bump_left)
                    next_state = STATE_WALK_RIGHT;
                else if (dig)
                    next_state = STATE_DIGGING;
                else
                    next_state = STATE_WALK_LEFT;
            end

            STATE_WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground)
                    next_state = STATE_FALLING;
                else if (bump_right)
                    next_state = STATE_WALK_LEFT;
                else if (dig)
                    next_state = STATE_DIGGING;
                else
                    next_state = STATE_WALK_RIGHT;
            end

            STATE_FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 5'd20)
                        next_state = STATE_SPLATTERED;
                    else if (walk_left)
                        next_state = STATE_WALK_LEFT;
                    else
                        next_state = STATE_WALK_RIGHT;
                end else
                    next_state = STATE_FALLING;
            end

            STATE_DIGGING: begin
                digging = 1'b1;
                if (!ground)
                    next_state = STATE_FALLING;
                else
                    next_state = STATE_DIGGING;
            end

            STATE_SPLATTERED: begin
                next_state = STATE_SPLATTERED;
            end

            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end
endmodule