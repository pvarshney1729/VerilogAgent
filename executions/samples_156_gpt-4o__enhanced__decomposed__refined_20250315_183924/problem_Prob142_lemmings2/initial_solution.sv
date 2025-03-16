module TopModule (
    input logic clk,          // Clock signal, triggers on the positive edge
    input logic areset,       // Asynchronous reset, active high
    input logic bump_left,    // Bump signal from the left
    input logic bump_right,   // Bump signal from the right
    input logic ground,       // Ground status, 1 when ground is present, 0 when falling
    output logic walk_left,   // Outputs 1 when Lemming is walking left
    output logic walk_right,  // Outputs 1 when Lemming is walking right
    output logic aaah         // Outputs 1 when Lemming is falling
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT  = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING    = 2'b10
    } state_t;

    state_t state, next_state;
    logic last_direction; // 0 for left, 1 for right

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            last_direction <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_RIGHT;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                end else if (bump_left || bump_right) begin
                    next_state = WALK_LEFT;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                if (ground) begin
                    next_state = last_direction ? WALK_RIGHT : WALK_LEFT;
                end else begin
                    next_state = FALLING;
                end
            end

            default: next_state = WALK_LEFT;
        endcase
    end

    // Output logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end

            WALK_RIGHT: begin
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end

            FALLING: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end

            default: begin
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
            end
        endcase
    end

    // Save the last walking direction before falling
    always_ff @(posedge clk) begin
        if (ground) begin
            if (state == WALK_LEFT) begin
                last_direction <= 0;
            end else if (state == WALK_RIGHT) begin
                last_direction <= 1;
            end
        end
    end

endmodule