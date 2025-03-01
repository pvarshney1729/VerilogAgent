module TopModule (
    input logic clk,               // Clock input, positive edge-triggered
    input logic areset,            // Asynchronous active-high reset
    input logic bump_left,         // Input signal indicating left obstacle
    input logic bump_right,        // Input signal indicating right obstacle
    output logic walk_left,        // Output signal indicating walking left
    output logic walk_right        // Output signal indicating walking right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b01,
        STATE_WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_left) 
                    next_state = STATE_WALK_RIGHT;
                else 
                    next_state = STATE_WALK_LEFT;
            end
            STATE_WALK_RIGHT: begin
                if (bump_right) 
                    next_state = STATE_WALK_LEFT;
                else 
                    next_state = STATE_WALK_RIGHT;
            end
            default: next_state = STATE_WALK_LEFT;
        endcase
    end

    // State flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= STATE_WALK_LEFT;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (current_state)
            STATE_WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            STATE_WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule