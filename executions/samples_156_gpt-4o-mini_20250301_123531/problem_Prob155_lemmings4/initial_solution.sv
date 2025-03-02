module TopModule (
    input  logic clk,          // Clock signal, positive edge-triggered
    input  logic areset,       // Asynchronous reset signal, active high
    input  logic bump_left,    // Bump from the left, active high
    input  logic bump_right,   // Bump from the right, active high
    input  logic ground,       // Ground presence signal, active high
    input  logic dig,          // Digging command signal, active high
    output logic walk_left,    // Lemming walking left indicator
    output logic walk_right,   // Lemming walking right indicator
    output logic aaah,         // Lemming falling indicator
    output logic digging       // Lemming digging indicator
);

    typedef enum logic [2:0] {
        WALK_LEFT,
        WALK_RIGHT,
        FALLING,
        DIGGING,
        SPLATTERED
    } state_t;

    state_t current_state, next_state;
    logic [4:0] fall_counter; // Counter for falling cycles

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
            fall_counter <= 5'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // State transition logic
    always_ff @(posedge clk) begin
        case (current_state)
            WALK_LEFT: begin
                if (ground == 1'b0) begin
                    next_state <= FALLING;
                end else if (bump_left == 1'b1) begin
                    next_state <= WALK_RIGHT;
                end else if (dig == 1'b1 && ground == 1'b1) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (ground == 1'b0) begin
                    next_state <= FALLING;
                end else if (bump_right == 1'b1) begin
                    next_state <= WALK_LEFT;
                end else if (dig == 1'b1 && ground == 1'b1) begin
                    next_state <= DIGGING;
                end else begin
                    next_state <= WALK_RIGHT;
                end
            end

            FALLING: begin
                fall_counter <= fall_counter + 1;
                if (ground == 1'b1) begin
                    if (fall_counter < 5'd21) begin
                        next_state <= (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                    end else begin
                        next_state <= SPLATTERED;
                    end
                end else begin
                    next_state <= FALLING;
                end
            end

            DIGGING: begin
                if (ground == 1'b0) begin
                    next_state <= FALLING;
                end else begin
                    next_state <= (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
            end

            SPLATTERED: begin
                next_state <= SPLATTERED; // Remain in splattered state
            end

            default: next_state <= WALK_LEFT; // Default to walking left
        endcase
    end

    // Output logic based on current state
    always_comb begin
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1'b1;
            end
            WALK_RIGHT: begin
                walk_right = 1'b1;
            end
            FALLING: begin
                aaah = 1'b1;
            end
            DIGGING: begin
                digging = 1'b1;
            end
            SPLATTERED: begin
                // No outputs active in splattered state
            end
        endcase
    end

endmodule