module TopModule (
    input logic clk,  // Clock signal, positive edge triggered
    input logic areset,  // Asynchronous reset, active high
    input logic bump_left,  // Bump signal from the left
    input logic bump_right,  // Bump signal from the right
    input logic ground,  // Ground presence signal
    input logic dig,  // Digging command signal
    output logic walk_left,  // Walking left state indicator
    output logic walk_right,  // Walking right state indicator
    output logic aaah,  // Falling state indicator
    output logic digging  // Digging state indicator
);

    // State Encoding
    typedef enum logic [2:0] {
        WALK_LEFT = 3'b000,
        WALK_RIGHT = 3'b001,
        FALLING = 3'b010,
        DIGGING = 3'b011,
        SPLATTERED = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Falling time counter
    integer fall_counter;

    // Asynchronous Reset: Reset state to walk left
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // State Transition Logic
    always @(*) begin
        // Default values
        next_state = current_state;
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
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1'b1;
                if (!ground) begin
                    next_state = FALLING;
                end else if (dig) begin
                    next_state = DIGGING;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;
                end
            end

            FALLING: begin
                aaah = 1'b1;
                if (ground) begin
                    if (fall_counter > 20) begin
                        next_state = SPLATTERED;
                    end else begin
                        next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
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
                // Remain in SPLATTERED state; all outputs remain 0
            end
        endcase
    end

    // Falling Counter Logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            fall_counter <= 0;
        end else if (current_state == FALLING) begin
            fall_counter <= fall_counter + 1;
        end else begin
            fall_counter <= 0;
        end
    end

endmodule