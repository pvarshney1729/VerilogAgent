module TopModule (
    input logic clk,           // Clock signal, positive edge-triggered
    input logic areset,        // Asynchronous active-high reset
    input logic bump_left,     // Input signal indicating an obstacle on the left
    input logic bump_right,    // Input signal indicating an obstacle on the right
    output logic walk_left,    // Output signal indicating walking left
    output logic walk_right    // Output signal indicating walking right
);

    typedef enum logic [1:0] {
        STATE_WALK_LEFT  = 2'b01,
        STATE_WALK_RIGHT = 2'b10
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= STATE_WALK_LEFT;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            STATE_WALK_LEFT: begin
                if (bump_left || (bump_left && bump_right)) begin
                    next_state = STATE_WALK_RIGHT;
                end else begin
                    next_state = STATE_WALK_LEFT;
                end
            end
            STATE_WALK_RIGHT: begin
                if (bump_right || (bump_left && bump_right)) begin
                    next_state = STATE_WALK_LEFT;
                end else begin
                    next_state = STATE_WALK_RIGHT;
                end
            end
            default: begin
                next_state = STATE_WALK_LEFT;
            end
        endcase
    end

    // Output logic
    always_comb begin
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