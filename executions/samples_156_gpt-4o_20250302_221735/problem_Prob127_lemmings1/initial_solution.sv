module TopModule (
    input logic clk,         // Clock signal, positive edge-triggered
    input logic areset,      // Asynchronous reset, active high
    input logic bump_left,   // Input signal indicating a bump on the left
    input logic bump_right,  // Input signal indicating a bump on the right
    output logic walk_left,  // Output signal indicating movement to the left
    output logic walk_right  // Output signal indicating movement to the right
);

    typedef enum logic [1:0] {
        WALK_LEFT = 2'b00,
        WALK_RIGHT = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                if (bump_left && bump_right)
                    next_state = WALK_RIGHT;
                else if (bump_left)
                    next_state = WALK_RIGHT;
                else
                    next_state = WALK_LEFT;
            end
            WALK_RIGHT: begin
                if (bump_left && bump_right)
                    next_state = WALK_LEFT;
                else if (bump_right)
                    next_state = WALK_LEFT;
                else
                    next_state = WALK_RIGHT;
            end
            default: next_state = WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else
            state <= next_state;
    end

    // Output logic
    always_comb begin
        case (state)
            WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule