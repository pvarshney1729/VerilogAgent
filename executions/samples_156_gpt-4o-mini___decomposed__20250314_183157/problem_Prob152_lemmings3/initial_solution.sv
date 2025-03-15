module TopModule (
    input logic clk,
    input logic areset,
    input logic bump_left,
    input logic bump_right,
    input logic ground,
    input logic dig,
    output logic walk_left,
    output logic walk_right,
    output logic aaah,
    output logic digging
);

    // State encoding
    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01,
        FALLING = 2'b10,
        DIGGING = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk) begin
        if (areset) begin
            current_state <= WALK_LEFT; // Reset to walk left
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for state transitions and output
    always_comb begin
        // Default values
        next_state = current_state;
        walk_left = 1'b0;
        walk_right = 1'b0;
        aaah = 1'b0;
        digging = 1'b0;

        case (current_state)
            WALK_LEFT: begin
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_right) begin
                    next_state = WALK_RIGHT;
                end
                walk_left = 1'b1;
            end
            
            WALK_RIGHT: begin
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end else if (dig) begin
                    next_state = DIGGING;
                    digging = 1'b1;
                end else if (bump_left) begin
                    next_state = WALK_LEFT;
                end
                walk_right = 1'b1;
            end
            
            FALLING: begin
                aaah = 1'b1; // Continue to say "aaah"
                if (ground) begin
                    next_state = (current_state == WALK_LEFT) ? WALK_LEFT : WALK_RIGHT;
                end
            end
            
            DIGGING: begin
                digging = 1'b1; // Continue digging
                if (!ground) begin
                    next_state = FALLING;
                    aaah = 1'b1;
                end
            end
        endcase
    end

endmodule