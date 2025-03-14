module TopModule (
    input logic clk,          // Clock signal, positive edge triggered
    input logic areset,      // Asynchronous reset, active high
    input logic bump_left,    // Input signal indicating bump on the left (1 bit)
    input logic bump_right,   // Input signal indicating bump on the right (1 bit)
    input logic ground,       // Input signal indicating the presence of ground (1 bit)
    output logic walk_left,    // Output signal indicating walking left (1 bit)
    output logic walk_right,   // Output signal indicating walking right (1 bit)
    output logic aaah          // Output signal indicating falling state (1 bit)
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default outputs
        walk_left = 0;
        walk_right = 0;
        aaah = 0;

        case (current_state)
            WALK_LEFT: begin
                walk_left = 1;
                if (bump_right) begin
                    next_state = WALK_RIGHT;
                end else if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = WALK_LEFT;
                end
            end

            WALK_RIGHT: begin
                walk_right = 1;
                if (bump_left) begin
                    next_state = WALK_LEFT;
                end else if (!ground) begin
                    next_state = FALLING;
                end else begin
                    next_state = WALK_RIGHT;
                end
            end

            FALLING: begin
                aaah = 1;
                if (ground) begin
                    if (current_state == WALK_LEFT) begin
                        next_state = WALK_LEFT;
                    end else begin
                        next_state = WALK_RIGHT;
                    end
                end else begin
                    next_state = FALLING;
                end
            end

            default: begin
                next_state = WALK_LEFT; // Default state
            end
        endcase
    end

endmodule